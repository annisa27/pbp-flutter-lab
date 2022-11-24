### Annisa Az Zahra - 2106701242 - PBP A
-----
# Tugas 9 PBP Gasal 2023
## Jawaban Soal

### Apakah bisa kita melakukan pengambilan data JSON tanpa membuat model terlebih dahulu? Jika iya, apakah hal tersebut lebih baik daripada membuat model sebelum melakukan pengambilan data JSON?
Kita dapat mengambil data JSON tanpa membuat model dengan cara membuat dynamic map dari JSON dan mengakses nilainya dengan konsep dictionary `('data[key]')`. Namun hal ini tidak lebih baik daripada membuat model sebelum melakukan pengambilan data JSON karena bisa saja terjadi perubahan struktur fields atau hilang atau malah tidak sesuai yang diinginkan, jika hal ini terjadi akan sulit dikelola.


### Sebutkan widget apa saja yang kamu pakai di proyek kali ini dan jelaskan fungsinya.
| Widget | Fungsi Widget | 
| :------------ |:--------------- |
| `Checkbox`    | Membuat checkbox dengan event onChange, akan berubah setiap value watchednya berubah. Pada tugas ini berfungsi untuk menandai film yang watched dan unwatched |
| `ListTile`    | menampung teks sebagai leading dan trailing |
| `TextButton`    | membuat button |


### Jelaskan mekanisme pengambilan data dari json hingga dapat ditampilkan pada Flutter.
Data Json yang telah disediakan sebelumnya pada halaman heroku, diambil menggunakan HTTP yang terdapat di fungsi `fetchWatchlist` yang akan memanggil fungsi GET yang mengembalikan daftar objek dari `MyWatchlist`. 

`FutureBuilder` akan memanggil fungsi dan menunggu responnya. Ketika datanya diambil, `FutureBuilder` akan mengembalikan `ListView.builder` yang membangun `ListTiles` dimana telah berisi data yang akan di-mapping dimana didapatkan dari fungsi `fetchWatchlist`

### Implementasi
1. Membuat page `watchlist.dart`
2. Menambahkan watchlist pada drawer
``` dart
    ListTile(
                title: const Text('My Watchlist'),
                onTap: () {
                // Route menu ke halaman data budget
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const MyWatchlistPage()),
                );
                },
            ),
```

3. Membuat 'fetch_watchlist.dart' dan menambahkan fungsi untuk mengambil data dari API.
``` dart
    Future<List<MyWatchlist>> fetchWatchlist() async {
    var url = Uri.parse('https://tugas-2-pbp-rifqi.herokuapp.com/mywatchlist/json/');
    var response = await http.get(
        url,
        headers: {
        "Access-Control-Allow-Origin": "*",
        "Content-Type": "application/json",
        },
    );

    // melakukan decode response menjadi bentuk json
    var data = jsonDecode(utf8.decode(response.bodyBytes));

    // melakukan konversi data json menjadi object MyWatchlist
    List<MyWatchlist> listMyWatchlist = [];
    for (var d in data) {
        if (d != null) {
        listMyWatchlist.add(MyWatchlist.fromJson(d));
        }
    }

    return listMyWatchlist;
    }
```

4. Menambahkan `MyWatchlistPage StatefulWidget` pada `watchlist.dart` yang berisi `FutureBuilder` disertai fungsi `fetchWatchlist` untuk mengambil data.

5. Membuat `watchlist_detail.dart` dan menambahkan `MyWatchlistDetailPage StatelessWidget` yang berfungsi untuk menampilkan data yang diambil dari `MyWatchlistPage`.

6. Meneruskan data dari `MyWatchlistPage` ke `MyWatchlistDetailPage` menggunakan `Navigator.push`
``` dart
    onTap: () {
        // Route menu ke halaman utama
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    MyWatchlistDetailPage(
                movie: snapshot.data![index],
                ),
            ));
        },
```

7. Menambahkna widget `CheckBox` dan fungsi `onChanged` untuk Bonus
``` dart
trailing: Checkbox(
    activeColor: Colors.limeAccent,
    checkColor: Colors.black,
    focusColor: Colors.lightGreenAccent,
    value: snapshot.data![index].fields.watched,
    onChanged: (bool? value) {
        setState(() {
        snapshot.data![index].fields.watched =
            value!;
        });
    },
    ),
```

-----
# Tugas 8 PBP Gasal 2023
## Jawaban Soal

### Jelaskan perbedaan Navigator.push dan Navigator.pushReplacement.
`Navigator.push` menambahkan Route lain ke atas stack dari Navigator

`Navigator.pushReplacement` akan menambahkan Route ke atas stack sekaligus menghilangkan Route yang sebelumnya (halaman saat ini akan di replace dengan halaman baru).

### Sebutkan widget apa saja yang kamu pakai di proyek kali ini dan jelaskan fungsinya.
| Widget | Fungsi Widget | 
| :------------ |:--------------- |
| `Row & Column`    | Menampilkan children-nya secara horizontal atau vertikal |
| `Text`    | Menampilkan sebuah string dengan single style |
| `Padding`    | Memberikan padding sebagai jarak pada child dengan konten pembungkus |
| `Center`    | Memposisikan childnya pada tengah halaman |
| `Card`    | Membuat card untuk menampilkan masing-masing informasi dari form |
| `Form` | Containter untuk melakukan grouping terhadap beberapa form field widget |
| `TextFormField` | Field text untuk input |
| `DropdownButtonFormField` | Menampilkan menu dropdown |
| `TextButton` | Membuat button dengan isi text |
| `InputDecoration` | Melakukan styling pada input |


### Sebutkan jenis-jenis event yang ada pada Flutter (contoh: onPressed).
| Event | Keterangan | 
| :------------ |:--------------- |
| `onPressed`    | Suatu fungsi akan dijalankan ketika widget selesai ditekan oleh user |
| `onSaved`    | Suatu fungsi akan dijalankan ketika user menyimpan form |
| `onChanged`    | event yang terjadi ketika ada perubahan |

### Jelaskan bagaimana cara kerja Navigator dalam "mengganti" halaman dari aplikasi Flutter.
Navigator menggunakan paradigma stack dalam mengganti halaman yakni LIFO (Last In First Out). Halaman yang ditampilkan adalah yang berada di atas stack (top of stack) ketika melakukan push.

### Jelaskan bagaimana cara kamu mengimplementasikan checklist di atas.
1. Menambahkan drawer/hamburger menu pada app yang telah dibuat sebeumnya dengan membuat berkas `drawer.dart` yang berisi widget `Drawer` dengan routing ke halaman counter_7, form, dan data_budget.
2. Menambahkan halaman form dengan membuat berkas `form.dart` yang berisi elemen input dan dropdown. Menambahkan input dengan tipe data berupa String untuk judul, int untuk nominal, dan Datetime.
3. Menyimpan data yang di-input ke dalam list dan di dalam bentuk card.
4. Menampilkan data berbentuk card ke halaman Data Budget dengan mengiterasi list.



-----


# Tugas 7 PBP Gasal 2023

## Jawaban Soal

### Jelaskan apa yang dimaksud dengan stateless widget dan stateful widget dan jelaskan perbedaan dari keduanya.
**Stateless widget** adalah widget yang tidak memiliki state, sehingga widget tersebut tidak akan berubah melalui internal action atau behaviour. Ketika kita ingin mengubah statless widget, kita harus mengatur instance baru untuk widget tersebut atau mengatur secara *hard-code*. Sedangkan **stateful widget** merupakan widget yang dinamis atau dapat berubah selama aplikasi dijalankan. 

Perbedaan di antara keduanya adalah, pada stateless widget kita tidak dapat memanggil fungsi `setState()` karena tidak ada state di widget tersebut namun jika di stateful widget bisa. Stateless widget hanya memiliki final properties yang berbeda dengan stateful widget. 

### Sebutkan widget apa saja yang kamu pakai di proyek kali ini dan jelaskan fungsinya.
1. Scaffold: berfungsi sebagai layout utama app
2. Appbar: berfungsi untuk menampilkan judul dari app
3. Center: berfungsi sebagai *layout-manager* untuk mengatur widget ke tengah halaman
4. Row: berfungsi sebagai *layout-manager* untuk mengatur susunan widget secara horizontal
5. Column: berfungsi sebagai *layout-manager* untuk mengatur susunan widget secara vertikal
6. Text: berfungsi untuk menampilkan text
7. Padding: berfungsi untuk menambahkan space kosong ke sekitar widget
8. Visibility: berfungsi untuk menampilkan widget jika suatu kondisi dipenuhi.
9. FloatingActionButton: berfungsi untuk menampilkan button berbentuk bulat pada app dan akan ditampilkan walau user melakukan *scrolling* karen sifatnya yang *floating*.
### Apa fungsi dari setState()? Jelaskan variabel apa saja yang dapat terdampak dengan fungsi tersebut.
`setState()` berfungsi untuk memberitahu framework bawah ada object yang telah berubah pada State, kemudian akan melakukan rebuild pada Widget. Sehingga widget pun akan menampilkan nilai yang telah diubah berdasarkan statenya.

Variabel yang terdampak pada tugas ini adalah variabel `_counter` yang digunakan di dalam widget `Text()`. Tujuan dari app ini adalah mengubah nilai dari variabel _counte jika ada trigger klik button, sehingga dibutuhkan pemanggilan fungsi `setState()` untuk mengubahnilai yang akan ditampilkan.

### Jelaskan perbedaan antara const dengan final.
Satu-satunya perbedaan antara final dan const adalah bahwa const membuat variabel konstan saat compile-time saja. Ketika melakukan deklarasi variable immutable const, valuenya harus sudah diketahu saat compile time sedangkan untuk final masih bisa diketahui nanti atau dapat dikatakan dapat diubah.

### Jelaskan bagaimana cara kamu mengimplementasikan checklist di atas.
1. Generate proyek Flutter dan masuk ke dalam direktori proyek dengan nama `counter_7` serta melakukan run dengan command:
    ```cmd
    flutter create counter_7
    cd counter_7
    flutter run
    ```

2. Menambahkan fungsi `_decrementCounter()` pada file [`main.dart`](lib/main.dart).
    ```dart
    void _decrementCounter(){
        setState(() {
        if(_counter < 1){
            return;
        }
        
        _counter--;
        });
    }
    ```

3. Membuat sebuah fungsi `checknum()` untuk menambahkan widget `Text()` yang menampilkan tipe dari angka.
    ```dart
    checknum(){
        if(_counter % 2 == 0){
            return Text("GENAP",
                        style: TextStyle(color: Colors.red,),
                    );
        } else{
            return Text("GANJIL", 
                        style: TextStyle(color: Colors.blue,),
                    );
        }
    }
    ```

4. Menambahkan widget `FloatingActionButton()` untuk button pengurangan serta mengatur visibility dan mealukan layouting terhadap button menggunakan `Padding()` dan `Row()`.
    ```dart
    floatingActionButton:  Padding(
        padding: EdgeInsets.all(48.0),
        child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
        Visibility(
            visible: _counter > 0,
            child: FloatingActionButton(
            onPressed: _decrementCounter,
            tooltip: 'Decrement',
            child: const Icon(Icons.remove),
            ),
        ),

        FloatingActionButton(
            onPressed: _incrementCounter,
            tooltip: 'Increment',
            child: const Icon(Icons.add),
        ),
        
        ],
    )
    )
    ```

5. Melakukan hot restart 🔥

