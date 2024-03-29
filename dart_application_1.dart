//ATM Bank Code
import 'dart:io';

void main() {
  int total = 0;
  int pin = 1234;
  Map<int, String> report = {
    1: 'Withdraw',
    2: 'Deposit',
    3: 'Account Balance',
  };
  while (true) {
    stdout.write('Enter your pin: ');
    int userInput = int.parse(stdin.readLineSync()!);

    if (pin == userInput) {
      print('Select your transaction: ');
      for (var element in report.entries) {
        print('${element.key}: ${element.value}');
      }
      stdout.write('Enter (1, 2, or 3): ');
      int result = int.parse(stdin.readLineSync()!);
      if (result < 1 || result > 3) {
        print('Enter a valid number (1, 2, or 3).');
        continue;
      }
      File file = File('bank.txt');

      if (!file.existsSync()) {
        file.writeAsStringSync('0');
      }

      int balance = int.parse(file.readAsStringSync());

      switch (result) {
        case 1:
          stdout.write('Enter the amount: \$');

          try {
            int amount = int.parse(stdin.readLineSync()!);
            if (balance < amount) {
              print('Insufficient Balance');
            } else if (amount < 0) {
              print('Enter a valid amount');
            } else {
              total = balance - amount;
              file.writeAsStringSync(total.toString());
              print('You withdraw $amount');
            }
          } on FormatException {
            print("Invalid input. Please enter a valid amount");
            break;
          }

        case 2:
          stdout.write('Enter the amount: \$');
          try {
            int amount = int.parse(stdin.readLineSync()!);
            if (amount < 10) {
              print('Error: You cannot deposit this amount.');
            } else {
              total = balance + amount;
              file.writeAsStringSync(total.toString());
              print('You deposit $amount');
            }
          } on FormatException {
            print("Invalid input. Please enter a valid amount");
          }

          break;
        case 3:
          String accountBalance = file.readAsStringSync();
          print('Your account balance is $accountBalance');
          break;
        default:
      }

      print('Do you want to perform another transaction');
      print('1: Yes\n2: No');
      stdout.write('Enter response: ');
      int response = int.parse(stdin.readLineSync()!);
      switch (response) {
        case 1:
          continue;
        case 2:
          print('Thank you for banking with us');
          print('GoodBye!');
          break;
        default:
      }
    } else {
      print('You entered a wrong pin');
      continue;
    }
    break;
  }
}
