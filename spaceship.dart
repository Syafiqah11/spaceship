import 'dart:math';

void main(){

  ArmoredSpaceShip ship1 = ArmoredSpaceShip(health: 1000.0, firePower: 50.0);
  HighSpeedSpaceShip ship2 = HighSpeedSpaceShip(health: 200.0, firePower: 250.0);
  BattleField().startBattle(ship1, ship2);
}

abstract class SpaceShip {
  double health = 0;
  double firePower = 0;

  SpaceShip(this.health, this.firePower);
  //Methods
  //hit
  void isHit(double oppositeFP);
  //isDestroyed
  void isDestroyed();
}

class BattleField {
  void startBattle(SpaceShip sp1, SpaceShip sp2) async{
    //Randomly a space ship is selected to hit first

    while(sp1.health > 0 && sp2.health > 0) {
      await Future.delayed(Duration(seconds: 2), (){
        final random = Random();
        bool startHit = random.nextBool();
        //SpaceShip hit each other
        if (startHit == true) {
          sp1.isHit(sp2.firePower);
        } else {
          sp2.isHit(sp1.firePower);
        }
      });
    }
    //Until one of them is destroyed
  }
}

class ArmoredSpaceShip extends SpaceShip{
  // int maxArmorPower;

  ArmoredSpaceShip({health, firePower}) : super(health, firePower);
  //Randomly absorbs hit
  @override
  void isHit(double oppositeFP){
    final random = Random();
    int hitArmored = random.nextInt(40) + 1;
    double hit = hitArmored / 100;
    double damage = oppositeFP - (oppositeFP * hit);
    health = health - damage;
    print('Armored Spaceship is attacked! Hit armored: $hitArmored %');
    print('Damage: $damage');

    isDestroyed();
  }
  @override
  void isDestroyed(){
    if (health <= 0) {
      print('');
      print('Armored Spaceship is destroyed. High Speed Spaceship wins!');
    } else {
      print('Armored Spaceship remaining health: $health');
      print('');
    }
  }
}

class HighSpeedSpaceShip extends SpaceShip{

  HighSpeedSpaceShip({health, firePower}) : super(health, firePower);
  //Whether dodges hit or not
  @override
  void isHit(double oppositeFP) {
    final random = Random();
    bool dodging = random.nextBool();
    print('High Speed Spaceship is attacked!');
    if (dodging == false) {
      health = health - oppositeFP;
      print('Damage : $oppositeFP');
    } else {
      print('Dodged! No damage');
    }

    isDestroyed();
  }

  @override
  void isDestroyed() {
    if (health <= 0) {
      print('');
      print('High Speed SpaceShip is destroyed. Armored Spaceship wins!');
    } else {
      print('High Speed SpaceShip remaining health: $health');
      print('');
    }
  }
}