# Proyek 3 dan Pemrograman Perangkat Bergerak

Mobile Version

## Arsitek.co
![logoco](https://user-images.githubusercontent.com/79303700/161211240-43b0031d-2c47-4055-977c-213192e6236c.png)

Untuk memenuhi tugas Mata Kuliah Proyek 3 dan Pemrograman Perangkat Bergerak.

Tautan ke Repository lain:

- [Repository API](https://github.com/Eko748/ArchitectApp-Web/tree/main/app/Http/Controllers/API)
- [Arsitek.co: Web Version](https://github.com/Eko748/ArchitectApp-Web)
- [Dokumen](https://github.com/Eko748/Dokumentasi)
- [Mockup Web](https://www.figma.com/file/Uvb7jXpQH1BoT2ULGVDv4n/Web?node-id=0%3A1)
- [Mockup Mobile](https://www.figma.com/file/m1ePrrwEZ1gz57B4FkQBfE/mobile?node-id=0%3A1)


## User Interface
### Guest
![Home](https://user-images.githubusercontent.com/79303700/175541068-1930c0e7-b03f-42c5-ab94-32a77aa8e97b.png)![Detail](https://user-images.githubusercontent.com/79303700/175541140-9dd8f1c2-0d3d-4434-b653-c0be7bd04399.png)![Proofile](https://user-images.githubusercontent.com/79303700/175541151-b20c9068-06d2-4a3d-9fa0-c90ebf2bc2b3.png)

### Owner
![home](https://user-images.githubusercontent.com/79303700/175541361-c8ff0faa-fef5-4bfb-afc6-b323f2a21259.png)![Lelang](https://user-images.githubusercontent.com/79303700/175542977-d36edd91-c925-4385-8e22-0c3749bdc25f.png)![lelang1](https://user-images.githubusercontent.com/79303700/175541467-e9707395-d165-4234-89db-52cc8105503c.png)
![Konsultan](https://user-images.githubusercontent.com/79303700/175541688-3733034d-2c22-42a8-9f86-c7cb82b69d60.png)![Konsultan1](https://user-images.githubusercontent.com/79303700/175542746-f6a8b5da-f67f-4875-82de-5398c83788c5.png)![Home1](https://user-images.githubusercontent.com/79303700/175542663-c44e1e31-9f54-4648-be09-4e0fb2908654.png)
![home2](https://user-images.githubusercontent.com/79303700/175542802-6e7eb5fb-6db8-437b-a7fb-cf14a1355f6f.png)![kontraktor](https://user-images.githubusercontent.com/79303700/175542841-345eab12-7f58-45fa-9d56-5d94c3a2848c.png)![kontraktor1](https://user-images.githubusercontent.com/79303700/175542873-33f6bc57-acb3-4bdb-b953-619dc0734aa6.png)
![Pesan](https://user-images.githubusercontent.com/79303700/175543035-b6f41425-e987-4280-b238-5e3a6f96aa90.png)![pesan1](https://user-images.githubusercontent.com/79303700/175543074-17f2ea0b-c6c3-4ce1-8d20-a015740000fa.png)![profile](https://user-images.githubusercontent.com/79303700/175543096-9f70798f-f557-4f0c-beb1-fe9a336a2000.png)
![Lelangsaya](https://user-images.githubusercontent.com/79303700/175543133-4757c50d-4905-40ac-89ef-e36b5685393d.png)![Lelangsaya1](https://user-images.githubusercontent.com/79303700/175543166-a653c16c-bda8-4676-982b-5fdae27400ec.png)![projecsaya](https://user-images.githubusercontent.com/79303700/175543218-b0f82410-6f0f-4f8a-8c11-9f6d46044a53.png)
![projecsaya1](https://user-images.githubusercontent.com/79303700/175543235-3074c16d-7fb7-4444-808c-cdde020c5390.png)![editpro](https://user-images.githubusercontent.com/79303700/175543275-5916330d-4e0a-4051-bc31-015ba229c716.png)![pass](https://user-images.githubusercontent.com/79303700/175543310-b9183e49-08a0-4a50-96f0-b7c186f07f1d.png)


## UML Class Diagram
### 1. Single Responsibility Principle (SRP)
####    Penjelasan:
####    Class GetConsultantResponse, Data Consultant dan ProfessionalScreen memliki satu tanggung jawab dan ketiganya memiliki hubungan aggregation.

![SOLID-SRP drawio](https://user-images.githubusercontent.com/79303700/175523574-0e2366cb-16f5-4fcd-9b82-6db9b3583e66.png)

### 2. Open-closed Principle (OCP)
####    Penjelasan:
####    Class ChatScreen merupakan class yang akan menampilkan Chat dan Penambahan class MessageTile tidak akan merubah class manapun.

![SOLID-OCP drawio](https://user-images.githubusercontent.com/79303700/175523588-2ff3aae6-f38e-4b33-a1a3-e64b5d4bafa0.png)

### 3. Liskov Substitution Principle (LSP)
####    Penjelasan:
####    Class User merupakan parent class sedangkan child classnya adalah Owner, Konsultan, Kontraktor, dan Admin sehingga method dari child class mewakili parent classnya 

![SOLID-LSP drawio (2)](https://user-images.githubusercontent.com/79303700/175532897-63940ac0-2bd4-4c27-8ade-4331d74115c6.png)

### 4. Interface Segregation Principle (ISP)
####    Penjelasan:
####    Class MustVerifyEmail merupakan suatu interface sehingga semua method abstractnya perlu dideskripsikan kembali.

![SOLID-ISP drawio](https://user-images.githubusercontent.com/79303700/175523607-c8669e6c-1c0f-4e14-aab9-9767e5d7e0ff.png)

### 5. Dependency Inversionn Principle (DIP)
####    Penjelasan:
####    Class OrderProject dan OrderKonstruksi merupakan suatu detail dan bergantung pada suatu class abstraksi yaitu ProjectOwner dan KonstruksiOwner. Sedangkan class abstraksi tersebut memiliki relasi dengan class lain.
![SOLID-DIP drawio](https://user-images.githubusercontent.com/79303700/175523623-ec9cae79-2a2e-4811-8c3e-b72acf4fc2e4.png)
