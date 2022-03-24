class ContractorServices {
  final String title;
  final String description;
  final int budget;
  final String client;
  final String desain;
  final String rab;

  ContractorServices({this.title, this.description, this.budget, this.client, this.desain, this.rab});
}

List<ContractorServices> mockContractorServices = [
  ContractorServices(
    title: "Renovasi ruang tamu",
    description: "Client ingin menata ulang ruang tamu dirumahnya. Targetnya adalah ruang tamu yang nyaman dan indah untuk dipandang",
    budget: 10000000,
    client: "Alvin Fernanda",
    desain: "rancangan-arsitektur.jpg",
    rab: "rab.jpg"
  ),
  ContractorServices(
    title: "Renovasi rumah",
    description: "Client ingin merenovasi rumah dengan desain minimalist. Selain itu pewarnaan rumah juga diubah menjadi lebih fresh",
    budget: 50000000,
    client: "Dimas Syahputra",
    desain: "rancangan-arsitektur.jpg",
    rab: "rab.jpg"
  ),
];

