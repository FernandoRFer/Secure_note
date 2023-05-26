// import 'dart:convert';
// import 'dart:developer';

// import 'package:atlas_mobile_plugin_card/atlas_mobile_plugin_card.dart';
// import 'package:pos/code/repositories/entities/facade/card_init_data_entity.dart';
// import 'package:pos/code/repositories/entities/facade/card_update_data_entity.dart';
// import 'package:pos/code/repositories/entities/facade/card_written_block.dart';
// import 'package:pos/code/repositories/entities/facade/sector_data_entity.dart';

// import '../code/repositories/entities/facade/sector_key_entity.dart';

// abstract class ICardHelper {
//   Future<List<SectorDataEntity>> readSectors(List<SectorKeyEntity> sectorKeys);
//   Future<List<CardWrittenBlockEntity>> writeCard(CardInitDataEntity command);
//   Future<int> detect();
//   void cancel();
//   bool isCanceled();
//   void enableCard();
//   // Future<int> initCard(CardInitCommandEntity command); // Now it's the same as writing card
// }

// class CardHelperImpl implements ICardHelper {
//   // ---- PUBLIC ---- //
//   @override
//   Future<List<SectorDataEntity>> readSectors(
//       List<SectorKeyEntity> sectorKeys) async {
//     var ret = <SectorDataEntity>[];
//     for (var key in sectorKeys) {
//       final serialNumber = await detect();
//       if (serialNumber != 0) {
//         var login = await AtlasMobilePluginCard.login(
//             serialNumber, key.sector * 4, key.key, KeyType.keyA);
//         if (login) {
//           var sectorData = <int>[];
//           for (var i = key.sector * 4; i < (key.sector * 4) + 3; i++) {
//             var dataReaded = await AtlasMobilePluginCard.read(i);

//             sectorData.addAll(dataReaded);
//           }

//           ret.add(SectorDataEntity(sector: key.sector, data: sectorData));
//         }
//       }
//     }

//     return ret;
//   }

//   /// Returns card written blocks
//   @override
//   Future<List<CardWrittenBlockEntity>> writeCard(CardInitDataEntity command,
//       [bool isInit = true]) async {
//     final writtenBlocks = <CardWrittenBlockEntity>[];

//     CardUpdateDataEntity commands;

//     if (isInit) {
//       // Card initialize
//       commands = command.initialize;
//     } else {
//       // Card data
//       commands = command;
//     }

//     for (var item in commands.blocks) {
//       // Vamos pegar a chave do setor
//       final sectorKey =
//           commands.keys.where((e) => e.sector == item.sector).first.key;

//       // Cada setor tem 4 blocos. Ex: (Setor 2 bloco 0) = bloco geral 8
//       final block = item.block + (item.sector * 4);

//       //  BLOCK = Escrita de dados.
//       if (item.type == "BLOCK") {
//         final data = List<int>.from(base64Decode(item.data));

//         if (data.length != 16) {
//           return writtenBlocks;
//         }

//         if (await _writeBlock(
//             block, sectorKey, data, isInit ? KeyType.keyA : KeyType.keyB)) {
//           writtenBlocks.add(
//               CardWrittenBlockEntity(sector: item.sector, block: item.block));
//         } else {
//           return writtenBlocks;
//         }
//       } else if (item.type == "DECREMENT") {
//         final qttDecrement = item.data as int;

//         for (int i = 0; i < qttDecrement; i++) {
//           if (await _decrementBlock(
//               block, sectorKey, isInit ? KeyType.keyA : KeyType.keyB)) {
//             writtenBlocks.add(
//                 CardWrittenBlockEntity(sector: item.sector, block: item.block));
//           } else {
//             return writtenBlocks;
//           }
//         }
//       } else {
//         throw Exception("Tipo de comando de gravação não implementado");
//       }
//     }

//     if (isInit) {
//       writtenBlocks.clear();
//       final successBlocks = await writeCard(command, false);
//       writtenBlocks.addAll(successBlocks);
//     }

//     return writtenBlocks;
//   }

//   @override
//   Future<int> detect() async {
//     if (_isCanceled) return 0;
//     final serialNumber = await AtlasMobilePluginCard.detect();
//     log("CardSerialNumber: $serialNumber");
//     return serialNumber;
//   }

//   @override
//   void cancel() {
//     _isCanceled = true;
//     AtlasMobilePluginCard.close();
//   }

//   @override
//   bool isCanceled() {
//     return _isCanceled;
//   }

//   @override
//   void enableCard() {
//     _isCanceled = false;
//   }

//   // @override
//   // Future<int> initCard(CardInitCommandEntity command) async {
//   //   _pause = false;
//   //   int qttOfBlocksWrited = 0;

//   //   // ignore: unnecessary_null_comparison
//   //   if (command.controlBlocks == null) {
//   //     return 0;
//   //   }

//   //   // First we need to write command blocks
//   //   for (var item in command.controlBlocks) {
//   //     // Vamos pegar a chave do setor
//   //     final sectorKey = <int>[255, 255, 255, 255, 255, 255];

//   //     // Cada setor tem 4 blocos. Ex: (Setor 2 bloco 0) = bloco geral 8
//   //     final block = item.block + (item.sector * 4);

//   //     //  BLOCK = Escrita de dados.
//   //     if (item.type == "BLOCK") {
//   //       final data = List<int>.from(base64Decode(item.data));

//   //       if (data.length != 16) {
//   //         return qttOfBlocksWrited;
//   //       }

//   //       if (await _writeBlock(block, sectorKey, data, KeyType.keyA)) {
//   //         qttOfBlocksWrited++;
//   //       } else {
//   //         return qttOfBlocksWrited;
//   //       }
//   //     } else if (item.type == "DECREMENT") {
//   //       final qttDecrement = item.data as int;

//   //       for (int i = 0; i < qttDecrement; i++) {
//   //         if (await _decrementBlock(block, sectorKey, KeyType.keyA)) {
//   //           qttOfBlocksWrited++;
//   //         } else {
//   //           return qttOfBlocksWrited;
//   //         }
//   //       }
//   //     } else {
//   //       throw Exception("Tipo de comando de gravação não implementado");
//   //     }
//   //   }

//   //   return qttOfBlocksWrited;
//   // }

//   // ---- END PUBLIC ---- //

//   // ---- PRIVATE ---- //
//   bool _isCanceled = false;

//   Future<bool> _writeBlock(int block, List<int> key, List<int> data,
//       [KeyType type = KeyType.keyB]) async {
//     final numSerie = await detect();
//     // ignore: unnecessary_null_comparison
//     if (numSerie == null || numSerie == 0) {
//       return false;
//     }

//     if (_isCanceled) {
//       return false;
//     }

//     if (await AtlasMobilePluginCard.login(numSerie, block, key, type)) {
//       return await AtlasMobilePluginCard.write(block, data);
//     }

//     return false;
//   }

//   Future<bool> _decrementBlock(int block, List<int> key,
//       [KeyType type = KeyType.keyB]) async {
//     final numSerie = await detect();
//     // ignore: unnecessary_null_comparison
//     if (numSerie == null || numSerie == 0) {
//       return false;
//     }

//     if (_isCanceled) {
//       return false;
//     }

//     if (await AtlasMobilePluginCard.login(numSerie, block, key, type)) {
//       return await AtlasMobilePluginCard.decrement(block);
//     }

//     return false;
//   }

//   // ---- END PRIVATE ---- //
// }
