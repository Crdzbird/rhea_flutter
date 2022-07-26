enum ReasonType {
  tooDifficult('reason_too_difficult'),
  feelingWorse('reason_feeling_worse'),
  retrylLater('reason_retry_later'),
  other('reason_other');

  const ReasonType(this.value);
  final String value;

  List<ReasonType> get reasons => [
        tooDifficult,
        feelingWorse,
        retrylLater,
        other,
      ];
}
