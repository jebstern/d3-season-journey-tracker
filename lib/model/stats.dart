class Stats {
  int amountChecked = 0;
  double amountCheckedPercentage = 0.0;
  String amountCheckedLabel = "0.0";
  String progress = "";

  void setCheckedValues(int amountChecked, int maxChallengesAmount) {
    this.amountChecked = amountChecked;
    amountCheckedLabel = (amountChecked / maxChallengesAmount * 100).toStringAsFixed(1);
    amountCheckedPercentage = double.parse((amountChecked / maxChallengesAmount).toStringAsFixed(1));
    progress = "$amountChecked/$maxChallengesAmount";
  }
}
