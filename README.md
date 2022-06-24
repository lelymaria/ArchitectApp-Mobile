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

[SOLID-LSP drawio (2)](https://user-images.githubusercontent.com/79303700/175532897-63940ac0-2bd4-4c27-8ade-4331d74115c6.png)

### 4. Interface Segregation Principle (ISP)
####    Penjelasan:
####    Class MustVerifyEmail merupakan suatu interface sehingga semua method abstractnya perlu dideskripsikan kembali.

![SOLID-ISP drawio](https://user-images.githubusercontent.com/79303700/175523607-c8669e6c-1c0f-4e14-aab9-9767e5d7e0ff.png)

### 5. Dependency Inversionn Principle (DIP)
####    Penjelasan:
####    Class OrderProject dan OrderKonstruksi merupakan suatu detail dan bergantung pada suatu class abstraksi yaitu ProjectOwner dan KonstruksiOwner. Sedangkan class abstraksi tersebut memiliki relasi dengan class lain.
![SOLID-DIP drawio](https://user-images.githubusercontent.com/79303700/175523623-ec9cae79-2a2e-4811-8c3e-b72acf4fc2e4.png)
