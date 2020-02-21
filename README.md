# SoalShiftSISOP20_modul1_E02

## Soal 1
Whits adalah seorang mahasiswa teknik informatika. Dia mendapatkan tugas praktikum untuk membuat laporan berdasarkan data yang ada pada file “​ Sample-Superstore.csv”. Namun dia tidak dapat menyelesaikan tugas tersebut. Laporan yang diminta berupa :

a. Tentukan wilayah bagian (region) mana yang memiliki keuntungan (profit) paling
sedikit

b. Tampilkan 2 negara bagian (state) yang memiliki keuntungan (profit) paling
sedikit berdasarkan hasil poin a

c. Tampilkan 10 produk (product name) yang memiliki keuntungan (profit) paling
sedikit berdasarkan 2 negara bagian (state) hasil poin b

Whits memohon kepada kalian yang sudah jago mengolah data untuk mengerjakan
laporan tersebut.

### Penyelesaian

Syntax awk yang digunakan untuk menyelesaikan poin (a) yaitu
```
awk -F '\t' '{a[$13] += $21} END {for (i in a) print a[i], i }' Sample-Superstore.tsv | sort -g | awk '{print $2}' | head -2 | tail -1
```
+ `-F '\t'` digunakan untuk memberitahu awk bahwa separator tiap kolom dari data yang kita miliki adalah tab.
+ `{a[$13] += $21}` menjumlahkan nilai pada kolom ke-21, yang menampung nilai keuntungan (profit), dari array a yang memiliki nama region (terletak pada kolom 13) yang sama.
+ `END{for (i in a) print a[i], i }` melakukan perulangan sebanyak region yang ada dan mencetak penjumlahan keuntungan berdasarkan region serta mencetak nama region.
+ `Sample-Superstore.tsv`merupakan nama file yang dijadikan input.
+ `sort -g` mengurutkan output dari perintah sebelumnya dari region yang memiliki keuntungan paling sedikit ke region yang memiliki keuntungan paling banyak.
+ `awk '{print $2}'` mencetak kolom kedua dari output perintah sebelumnya yang berisi region.
+ `head -2` mengambil dua record teratas dari output perintah sebelumnya.
+ `tail -1` mengambil record terbawah dari output perintah sebelumnya.

Berikut ini syntax awk yang digunakan untuk menyelesaikan poin (b). Iterasi dilakukan untuk menyimpan hasil awk pada array karena hasil ini akan digunakan pada poin (c).
```
for state in `awk -F '\t' -v region="$region" '($13~region) {a[$11] += $21} END {for (i in a) print a[i], i}' Sample-Superstore.tsv | sort -g | awk '{print $2}' | head -2`
do
    arr[$i]=$state
    echo ${arr[$i]}
    i=`expr $i + 1`
done
```
+ `-v region="$region"` membuat variabel region yang berisi $region yang menyimpan output dari poin (a).
+ `($13~region)` memeriksa apakah dalam record di kolom 13 (kolom region) terdapat string yang terkandung dalam variabel region.
+ `arr[$i]=$state` menyimpan hasil awk dalam array arr.

Syntax awk berikut digunakan untuk menyelesaikan poin (c).
```
awk -F '\t' -v satu="${arr[0]}" -v dua="${arr[1]}" '
    {if ( $11==satu || $11==dua) 
    a[$17]+=$21} 
    END{ for (i in a) 
    print a[i], i}' Sample-Superstore.tsv | sort -rg | awk '{sub($1 FS,""); print}' | tail -10
```
+ `-v satu="${arr[0]}"` dan `-v dua="${arr[1]}"` membuat varibel dengan nama satu dan dua yang berisi state dari poin (b).
+ `if ( $11==satu || $11==dua)` memeriksa apakah kolom 11, yang berisi state, sama dengan state dari poin (b). Jika benar maka `a[$17]+=$21`.
+ `sort -rg` mengurutkan output dari perintah sebelumnya dari produk yang memiliki keuntungan paling banyak hingga ke paling sedikit.
+ `awk '{sub($1 FS,""); print}'` mencetak semua kolom kecuali kolom pertama dan menghilangkan spasi dari output perintah sebelumnya.


## Soal 2
Pada suatu siang, laptop Randolf dan Afairuzr dibajak oleh seseorang dan kehilangan data-data penting. Untuk mencegah kejadian yang sama terulang kembali mereka meminta bantuan kepada Whits karena dia adalah seorang yang punya banyak ide. Whits memikirkan sebuah ide namun dia meminta bantuan kalian kembali agar ide tersebut cepat diselesaikan. Idenya adalah kalian (a) membuat sebuah script bash yang dapat menghasilkan password secara acak sebanyak 28 karakter yang terdapat huruf besar, huruf kecil, dan angka. (b) Password acak tersebut disimpan pada file berekstensi .txt dengan nama berdasarkan argumen yang diinputkan dan ​ HANYA ​ berupa alphabet​ . (c) Kemudian supaya file .txt tersebut tidak mudah diketahui maka nama filenya akan dienkripsi dengan menggunakan konversi huruf (string manipulation) yang disesuaikan dengan jam(0-23) dibuatnya file tersebut dengan program terpisah dengan (misal: password.txt dibuat pada jam 01.28 maka namanya berubah menjadi qbttxpse.txt dengan perintah ‘​ bash soal2_enkripsi.sh password.txt’. Karena p adalah huruf ke 16 dan file dibuat pada jam 1 maka 16+1=17 dan huruf ke 17 adalah q dan begitu pula seterusnya. Apabila melebihi ​ z ​ , akan kembali ke ​ a ​ , contoh: huruf ​ w dengan jam 5.28, maka akan menjadi huruf ​ b.​ ) dan (d) jangan lupa untuk membuat dekripsinya supaya nama file bisa kembali.

### Penyelesaian

Berikut merupakan script bash yang dapat menghasilkan random password sebanyak 28 karakter dengan huruf besar, huruf kecil, dan angka.
```bash
cat /dev/urandom | tr -dc A-Za-z0-9 | head -c 28 > $*.txt
```
+ `cat /dev/urandom` menampilkan bagian awal dari /dev/urandom
+ `tr -dc A-Za-z0-9` digunakan agar yang tersisa hanya huruf besar, huruf kecil, dan angka dari output perintah sebelumnya.
+ `head -c 28 > $*.txt` digunakan untuk mengambil 28 karakter pertama dari output perintah sebelumnya dan mengirimkan hasilnya ke file .txt dengan nama berdasarkan argumen yang diinputkan.

Agar nama file .txt hanya berupa alphabet maka dilakukan pengecekan dan penghapusan karakter selain alphabet dengan script bash berikut.
```
file="$(echo $* | sed 's/[^A-Za-z]*//g')"
namafile="${file%txt}"
```
+ `echo $*` menampilkan argumen yang diinputkan.
+ `sed 's/[^A-Za-z]*//g'` digunakan agar yang tersisa dari output perintah sebelumnya hanya alphabet.
+ `namafile="${file%txt}"` digunakan untuk memisahkan nama file dari extensinya.

Fungsi berikut digunakan untuk mengenkripsi nama file agar sesuai dengan permintaan poin (c).
```
enkripsi (){
    str=$1
    arr=()
    i=0
    z=122
    hour=`date +%H`

    while [ "$i" -lt "${#str}" ]; 
        do
        an="$(printf '%d\n' "'${str:$i:1}")"        
        let total=$an+$hour

        if [ $total -gt $z ]
            then
            let total-=26
        fi

        arr+=("$(printf '%b' $(printf '\\x%x' $total))")
        i=$((i+1))
    done

    result="$(printf '%s' "${arr[@]}")"
}
```
+ `str=$1` inisialisasi variabel str yang menampung argumen yang diinputkan.
+ `arr()` deklarasi array arr untuk menampung argumen yang sudah dienkripsi.
+ `i=0` inisialisasi variabel i sebagai iterator.
+ `z=122` inisialisasi variabel z yang menampung nilai ASCII dari huruf z.
+ `hour=`date +%H`` inisialisasi variabel hour yang menyimpan jam pada saat fungsi dijalankan.

```
while [ "$i" -lt "${#str}" ]; 
    do
    an="$(printf '%d\n' "'${str:$i:1}")"
    let total=$an+$hour

    if [ $total -gt $z ]
        then
        let total-=26
    fi

    arr+=("$(printf '%b' $(printf '\\x%x' $total))")
    i=$((i+1))
done
```
Iterasi ini dilakukan untuk mengenkripsi argumen yang diinputkan selama iterator lebih kecil sama dengan panjang argumen.
+ `an="$(printf '%d\n' "'${str:$i:1}")"` inisialisasi variabel an yang menampung nilai ASCII dari huruf yang sedang dienkripsi.
+ `let total=$an+$hour` inisialisasi variabel total yang menampung nilai ASCII dari huruf yang sedang dienkripsi ditambah jam pada saat fungsi dijalankan.
+ `if [ $total -gt $z ]` memeriksa apakah nilai $total lebih besar daripada nilai $z. Jika benar maka `let total-=26` dimana total yang sudah ada dikurangi 26 lalu dimasukan kembali pada variabel total.
+ `arr+=("$(printf '%b' $(printf '\\x%x' $total))")` untuk mengubah nilai ASCII ke kembali huruf dan menyimpannya ke dalam array arr.
+ `i=$((i+1))` untuk meng-increment iterator.

Hasil fungsi ini kemudian ditampung pada variabel result dengan `result="$(printf '%s' "${arr[@]}")"`. File yang sebelumnya bernama `$*.txt` diubah menjadi `$result.txt` dengan script bash berikut `mv "$*" "$result.txt"`.

Untuk melakukan dekripsi pada poin (d), dilakukan pemanggilan fungsi dekripsi(). Namun sebelum itu, hendaknya kita menyimpan jam ketika mengenkripsi argumen yang diinputkan dengan script bash `echo $hour > "log_$result".txt`.
```
dekripsi (){
    str=$1
    arr=()
    i=0
    a=97

    hour=$(cat log_$1.txt)

    while [ "$i" -lt "${#str}" ]; 
        do
        an="$(printf '%d\n' "'${str:$i:1}")"
        let total=$an-$hour

        if [ $total -lt $a ]
            then
            let total+=26
        fi

        arr+=("$(printf '%b' $(printf '\\x%x' $total))")
        i=$((i+1))
    done

    back="$(printf '%s' "${arr[@]}")"   
}
```
+ Variabel `str=$1` , `arr()` , dan `i=0` pada fungsi dekripsi() memiliki fungsi yang sama dengan variabel pada fungsi enkripsi().
+ `a=97` inisialisasi variabel a yang menampung nilai ASCII dari huruf a.
+ `hour=$(cat log_$1.txt)` inisialisasi variabel hour yang menyimpan jam pada saat fungsi enkripsi dijalankan.
```
while [ "$i" -lt "${#str}" ]; 
    do
    an="$(printf '%d\n' "'${str:$i:1}")"
    let total=$an-$hour

    if [ $total -lt $a ]
        then
        let total+=26
    fi

    arr+=("$(printf '%b' $(printf '\\x%x' $total))")
    i=$((i+1))
done
```
Iterasi disini merupakan kebalikan dari iterasi pada fungsi enkripsi() dan dilakukan selama selama iterator lebih kecil sama dengan panjang argumen dimana argumen disini adalah nama file yang telah dienkripsi.
+ `an="$(printf '%d\n' "'${str:$i:1}")"` inisialisasi variabel an yang menampung nilai ASCII dari huruf yang sedang didekripsi.
+ `let total=$an-$hour` inisialisasi variabel total yang menampung nilai ASCII dari huruf yang sedang didekripsi dikurangi jam pada saat fungsi enkripsi dijalankan.
+ `if [ $total -lt $a ]` memeriksa apakah nilai $total lebih kecil sama dengan nilai $z. Jika benar maka `let total+=26` dimana total yang sudah ada ditambah 26 lalu dimasukan kembali pada variabel total.
+ Variabel `arr+=("$(printf '%b' $(printf '\\x%x' $total))")` dan `i=$((i+1))` pada fungsi ini memiliki fungsi yang sama dengan variabel pada fungsi enkripsi().

Setelah selesai melakukan iterasi, hasil dari dekripsi tersebut ditampung pada array arr dengan script bash `back="$(printf '%s' "${arr[@]}")"`. Nama file yang telah dienkripsi diubah kembali menjadi nama file sebelum dienkripsi dengan `mv "$result.txt" "$back.txt"`.
