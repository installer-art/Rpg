import 'dart:io';

// 캐릭터 클래스 (플레이어와 몬스터 공통)
class Character {
  String name;
  int health;
  int attackPower;

  Character(this.name, this.health, this.attackPower);

  // 공격하는 함수
  void attack(Character target) {
    print('$name(이)가 ${target.name}에게 $attackPower의 데미지를 입혔습니다.');
    target.health -= attackPower;
  }

  // 살아있는지 확인하는 함수
  bool isAlive() {
    return health > 0;
  }
}

void main() {
  // 플레이어 정보 입력
  stdout.write('당신의 캐릭터 이름을 입력하세요: ');
  String playerName = stdin.readLineSync() ?? 'Player';

  // 플레이어와 몬스터 생성
  Character player = Character(playerName, 50, 10);
  Character monster = Character('몬스터', 20, 5);

  print('\n===== 전투 시작! =====');
  print('${player.name}: 체력(${player.health}), 공격력(${player.attackPower})');
  print(
    '${monster.name}: 체력(${monster.health}), 공격력(${monster.attackPower})\n',
  );

  // 전투 루프
  while (player.isAlive() && monster.isAlive()) {
    // 플레이어 턴
    print('${player.name}의 턴입니다.');
    stdout.write('행동을 선택하세요 (1: 공격, 2: 회복): ');
    String? input = stdin.readLineSync();

    if (input == '1') {
      player.attack(monster);
    } else if (input == '2') {
      player.health += 5;
      print('${player.name}(이)가 체력을 회복하여 +5 회복되었습니다. 현재 체력: ${player.health}');
    } else {
      print('잘못된 입력입니다.');
      continue;
    }

    // 몬스터 사망 확인
    if (!monster.isAlive()) {
      print('\n🎉 ${monster.name}을(를) 물리쳤습니다! 🎉');
      break;
    }

    // 몬스터 턴
    print('\n${monster.name}의 턴입니다.');
    monster.attack(player);

    // 플레이어 사망 확인
    if (!player.isAlive()) {
      print('\n💀 ${player.name}(이)가 쓰러졌습니다. 게임 오버! 💀');
      break;
    }

    print('\n==========\n');
  }

  print('게임 종료!');
}
