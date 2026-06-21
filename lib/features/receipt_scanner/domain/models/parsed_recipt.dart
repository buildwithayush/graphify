class ParsedReceipt {
  final double amount;
  final String category;
  final DateTime date;

  ParsedReceipt({
  required this.amount,
  required this.category,
  required this.date
  });

  @override
  String toString(){
    return 'ParrcedRecipt(category : $category , amount : $amount , date : $date)';
  }
}