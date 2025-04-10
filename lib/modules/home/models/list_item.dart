class ListItem {
  final String imageUrl;
  final String name;
  final String subtitle;

  ListItem({
    required this.imageUrl,
    required this.name,
    required this.subtitle,
  });
}

final List<ListItem> items = [
  ListItem(
    imageUrl: 'https://media.istockphoto.com/id/1147544807/vector/thumbnail-image-vector-graphic.jpg?s=612x612&w=0&k=20&c=rnCKVbdxqkjlcs3xH87-9gocETqpspHFXu5dIGB4wuM=',
    name: 'John Doe',
    subtitle: 'Software Engineer',
  ),
  ListItem(
    imageUrl: 'https://media.istockphoto.com/id/1147544807/vector/thumbnail-image-vector-graphic.jpg?s=612x612&w=0&k=20&c=rnCKVbdxqkjlcs3xH87-9gocETqpspHFXu5dIGB4wuM=',
    name: 'Jane Smith',
    subtitle: 'Product Designer',
  ),
  ListItem(
    imageUrl: 'https://media.istockphoto.com/id/1147544807/vector/thumbnail-image-vector-graphic.jpg?s=612x612&w=0&k=20&c=rnCKVbdxqkjlcs3xH87-9gocETqpspHFXu5dIGB4wuM=',
    name: 'Alex Johnson',
    subtitle: 'Data Scientist',
  ),
  ListItem(
    imageUrl: 'https://media.istockphoto.com/id/1147544807/vector/thumbnail-image-vector-graphic.jpg?s=612x612&w=0&k=20&c=rnCKVbdxqkjlcs3xH87-9gocETqpspHFXu5dIGB4wuM=',
    name: 'Emily Brown',
    subtitle: 'Marketing Manager',
  ),
  // Add more items...
];
