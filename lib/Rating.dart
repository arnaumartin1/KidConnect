class Rating {
  final String serviceId;
  final double score;
  final String comment;

  Rating({
    required this.serviceId,
    required this.score,
    required this.comment,
  });
}

// Lista global de valoraciones
final List<Rating> mockRatings = [];