### Annisa Az Zahra - 2106701242 - PBP A
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

