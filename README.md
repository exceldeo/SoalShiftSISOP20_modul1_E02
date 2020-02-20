# SoalShiftSISOP20_modul1_E02

## Soal 2
Pada suatu siang, laptop Randolf dan Afairuzr dibajak oleh seseorang dan kehilangan data-data penting. Untuk mencegah kejadian yang sama terulang kembali mereka meminta bantuan kepada Whits karena dia adalah seorang yang punya banyak ide. Whits memikirkan sebuah ide namun dia meminta bantuan kalian kembali agar ide tersebut cepat diselesaikan. Idenya adalah kalian (a) membuat sebuah script bash yang dapat menghasilkan password secara acak sebanyak 28 karakter yang terdapat huruf besar, huruf kecil, dan angka. (b) Password acak tersebut disimpan pada file berekstensi .txt dengan nama berdasarkan argumen yang diinputkan dan ​ HANYA ​ berupa alphabet​ . (c) Kemudian supaya file .txt tersebut tidak mudah diketahui maka nama filenya akan di enkripsi dengan menggunakan konversi huruf (string manipulation) yang disesuaikan dengan jam(0-23) dibuatnya file tersebut dengan program terpisah dengan (misal: password.txt dibuat pada jam 01.28 maka namanya berubah menjadi qbttxpse.txt dengan perintah ‘​ bash soal2_enkripsi.sh password.txt’. Karena p adalah huruf ke 16 dan file dibuat pada jam 1 maka 16+1=17 dan huruf ke 17 adalah q dan begitu pula
seterusnya. Apabila melebihi ​ z ​ , akan kembali ke ​ a ​ , contoh: huruf ​ w dengan jam 5.28, maka akan menjadi huruf ​ b.​ ) dan (d) jangan lupa untuk membuat dekripsinya supaya nama file bisa kembali.
### Penyelesaian
(a)
Berikut merupakan script bash yang dapat menghasilkan random password sebanyak 28 karakter dengan huruf besar, huruf kecil, dan angka.
```bash
cat /dev/urandom | tr -dc A-Za-z0-9 | head -c 28 > $*.txt
```
+ `cat /dev/urandom` menampilkan bagian awal dari /dev/urandom
+ `tr -dc A-Za-z0-9` digunakan agar yang tersisa hanya huruf besar, huruf kecil, dan angka dari output perintah sebelumnya.
+ `head -c 28 > $*.txt` digunakan untuk mengambil 28 karakter pertama dari output perintah sebelumnya dan mengirimkan hasilnya ke file .txt dengan nama berdasarkan argumen yang diinputkan.

(b)
Agar nama file .txt hanya berupa alphabet maka dilakukan pengecekan dan penghapusan karakter selain alphabet dengan script bash berikut.
```
file="$(echo $* | sed 's/[^A-Za-z]*//g')"
namafile="${file%txt}"
```
+ `echo $*` menampilkan argumen yang diinputkan.
+ `sed 's/[^A-Za-z]*//g'` digunakan agar yang tersisa dari output perintah sebelumnya hanya alphabet.
+ `namafile="${file%txt}"` digunakan untuk memisahkan nama file dari extensinya.

(c)
Fungsi berikut digunakan untuk mengenkripsi nama file agar sesuai dengan permintaan soal.
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
Hasil fungsi ini kemudian ditampung pada variabel result dengan `result="$(printf '%s' "${arr[@]}")"`. File yang sebelumnya bernama `$*.txt` diubah menjadi `$result.txt` dengan script bash berikut.
```
mv "$*" "$result.txt"
```
