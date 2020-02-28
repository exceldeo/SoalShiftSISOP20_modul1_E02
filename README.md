# SoalShiftSISOP20_modul1_E02

## Soal #1
Whits adalah seorang mahasiswa teknik informatika. Dia mendapatkan tugas praktikum untuk membuat laporan berdasarkan data yang ada pada file “​ Sample-Superstore.csv”. Namun dia tidak dapat menyelesaikan tugas tersebut. Laporan yang diminta berupa :

a. Tentukan wilayah bagian (region) mana yang memiliki keuntungan (profit) paling sedikit

b. Tampilkan 2 negara bagian (state) yang memiliki keuntungan (profit) paling sedikit berdasarkan hasil poin a

c. Tampilkan 10 produk (product name) yang memiliki keuntungan (profit) paling sedikit berdasarkan 2 negara bagian (state) hasil poin b

Whits memohon kepada kalian yang sudah jago mengolah data untuk mengerjakan laporan tersebut.

### Penyelesaian

Syntax awk yang digunakan untuk menyelesaikan poin (a) yaitu :
```awk
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
```bash
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

Syntax awk berikut digunakan untuk menyelesaikan poin (c) :
```awk
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

---

## Soal #2
Pada suatu siang, laptop Randolf dan Afairuzr dibajak oleh seseorang dan kehilangan data-data penting. Untuk mencegah kejadian yang sama terulang kembali mereka meminta bantuan kepada Whits karena dia adalah seorang yang punya banyak ide. Whits memikirkan sebuah ide namun dia meminta bantuan kalian kembali agar ide tersebut cepat diselesaikan. Idenya adalah kalian (a) membuat sebuah script bash yang dapat menghasilkan password secara acak sebanyak 28 karakter yang terdapat huruf besar, huruf kecil, dan angka. (b) Password acak tersebut disimpan pada file berekstensi .txt dengan nama berdasarkan argumen yang diinputkan dan HANYA berupa alphabet . (c) Kemudian supaya file .txt tersebut tidak mudah diketahui maka nama filenya akan dienkripsi dengan menggunakan konversi huruf (string manipulation) yang disesuaikan dengan jam(0-23) dibuatnya file tersebut dengan program terpisah dengan (misal: password.txt dibuat pada jam 01.28 maka namanya berubah menjadi qbttxpse.txt dengan perintah ‘*bash soal2_enkripsi.sh password.txt*’. Karena p adalah huruf ke 16 dan file dibuat pada jam 1 maka 16+1=17 dan huruf ke 17 adalah q dan begitu pula seterusnya. Apabila melebihi *z* , akan kembali ke *a* , contoh: huruf *w* dengan jam 5.28, maka akan menjadi huruf *b*. ) dan (d) jangan lupa untuk membuat dekripsinya supaya nama file bisa kembali.

### Penyelesaian

Berikut merupakan script bash yang dapat menghasilkan random password sebanyak 28 karakter dengan kombinasi huruf besar, huruf kecil, dan angka.
```bash
cat /dev/urandom | tr -dc A-Za-z0-9 | head -c 28 > $*
```
+ `cat /dev/urandom` menampilkan bagian awal dari /dev/urandom
+ `tr -dc A-Za-z0-9` digunakan agar yang tersisa hanya huruf besar, huruf kecil, dan angka dari output perintah sebelumnya.
+ `head -c 28 > $*` digunakan untuk mengambil 28 karakter pertama dari output perintah sebelumnya dan mengirimkan hasilnya ke file .txt dengan nama berdasarkan argumen yang diinputkan.

Agar nama file .txt hanya berupa alphabet maka dilakukan pengecekan dan penghapusan karakter selain alphabet dengan script bash berikut.
```bash
file="$(echo $* | sed 's/[^A-Za-z]*//g')"
namafile="${file%txt}"

mv "$*" "$namafile".txt 
```
+ `echo $*` menampilkan argumen yang diinputkan.
+ `sed 's/[^A-Za-z]*//g'` digunakan agar yang tersisa dari output perintah sebelumnya hanya alphabet.
+ `namafile="${file%txt}"` digunakan untuk memisahkan nama file dari extensinya.
+ `mv "$*" "$namafile".txt` mengganti nama file yang sebelumnya terdapat angka/simbol menjadi hanya alphabet saja.

Untuk mengenkripsi nama file agar sesuai dengan permintaan pada poin (c), kita menggunakan perintah *bash soal2_enkripsi.sh namafile.txt* dengan script di bawah ini.
```bash
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

```bash
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

Untuk melakukan dekripsi pada poin (d), dilakukan pemanggilan fungsi dekripsi(). Namun sebelum itu, hendaknya kita menyimpan jam ketika mengenkripsi argumen yang diinputkan dengan script bash `echo $hour > "./log/log_$result".txt` pada file soal2_enkripsi.sh. Fungsi dekripsi ini terdapat pada file soal2_dekripsi.sh.
```bash
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
+ `hour=$(cat ./log/log_$1.txt)` inisialisasi variabel hour yang menyimpan jam pada saat fungsi enkripsi dijalankan.
```bash
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

Setelah selesai melakukan iterasi, hasil dari dekripsi tersebut ditampung pada array arr dengan script bash `back="$(printf '%s' "${arr[@]}")"`. Nama file yang telah dienkripsi diubah kembali menjadi nama file sebelum dienkripsi dengan `mv "$*" "$back.txt"`.

---

## Soal #3
1 tahun telah berlalu sejak pencampakan hati Kusuma. Akankah sang pujaan hati kembali ke naungan Kusuma? Memang tiada maaf bagi Elen. Tapi apa daya hati yang sudah hancur, Kusuma masih terguncang akan sikap Elen. Melihat kesedihan Kusuma, kalian mencoba menghibur Kusuma dengan mengirimkan gambar kucing. (a)  Maka dari itu, kalian mencoba membuat script untuk mendownload 28 gambar dari "https://loremflickr.com/320/240/cat" menggunakan command wget dan menyimpan file dengan nama "pdkt_kusuma_NO" (contoh: pdkt_kusuma_1, pdkt_kusuma_2, pdkt_kusuma_3) serta jangan lupa untuk menyimpan log messages wget kedalam sebuah file "wget.log" . Karena kalian gak suka ribet, kalian membuat penjadwalan untuk menjalankan script download gambar tersebut. Namun, script download tersebut hanya berjalan (b) setiap 8 jam dimulai dari jam 6.05 setiap hari kecuali hari Sabtu. Karena gambar yang didownload dari link tersebut bersifat random, maka ada kemungkinan gambar yang terdownload itu identik. Supaya gambar yang identik tidak dikira Kusuma sebagai spam, maka diperlukan sebuah script untuk memindahkan salah satu gambar identik. Setelah memilah gambar yang identik, maka dihasilkan gambar yang berbeda antara satu dengan yang lain. Gambar yang berbeda tersebut, akan kalian kirim ke Kusuma supaya hatinya kembali ceria. Setelah semua gambar telah dikirim, kalian akan selalu menghibur Kusuma, jadi gambar yang telah terkirim tadi akan kalian simpan kedalam folder /kenangan dan kalian bisa mendownload gambar baru lagi. (c) Maka dari itu buatlah sebuah script untuk mengidentifikasi gambar yang identik dari keseluruhan gambar yang terdownload tadi. Bila terindikasi sebagai gambar yang identik, maka sisakan 1 gambar dan pindahkan sisa file identik tersebut ke dalam folder ./duplicate dengan format filename "duplicate_nomor" (contoh : duplicate_200, duplicate_201). Setelah itu lakukan pemindahan semua gambar yang tersisa kedalam folder ./kenangan dengan format filename "kenangan_nomor" (contoh: kenangan_252, kenangan_253). Setelah tidak ada gambar di ​ current directory , maka lakukan backup seluruh log menjadi ekstensi ".log bak".

### Penyelesaian

Untuk mendownload 28 gambar dari "https://loremflickr.com/320/240/cat", kami menggunakan command wget dengan `-O pdkt_kusuma_$index.jpg` untuk menyimpan gambar yang didownload dengan nama pdkt_kusuma_nomor.jpg dan `-a wget.log` untuk menambahkan log messages ke dalam file wget.log.
```bash
jumlah = 28

readarray arr < location.log
index=${#arr[@]}

download () {
    for ((num=1; num<=$jumlah; num=num+1))
    do
        index=$((index+=1))
        wget https://loremflickr.com/320/240/cat -O pdkt_kusuma_$indexjpg -a wget.log
    done
}

download
grep "Location" wget.log > location.log
```
+ `readarray arr < location.log` membaca baris dari file location.log dan memasukkannya ke array arr.
+ `index=${#arr[@]}` inisialisasi variabel index yang menampung size dari array arr.
+ `index=$((index+=1))` operasi yang meng-increment variabel index.
+ `grep "Location" wget.log > location.log` menampilkan baris pada file wget.log yang mengandung kata `Location` dan memasukkannya ke file location.log

Agar script download tersebut hanya berjalan setiap 8 jam dimulai dari jam 6.05 setiap hari kecuali hari Sabtu, maka digunakan crontab berikut.
```
5 6-23/8 * * 0-5 cd /home/excel/Desktop/SoalShiftSISOP20_modul1_E02/soal3;bash /home/excel/Desktop/SoalShiftSISOP20_modul1_E02/soal3/soal3.sh
```
`5` pada crontab di atas menunjukkan menit, `6-23/8` menunjukkan setiap 8 jam dari jam 6 sampai 23, `*` pertama menunjukkan tanggal berapapun, `*` kedua menunjukkan bulan berapapun, dan `0-5` menunjukkan dari hari Minggu sampai Jumat.

Pada poin (c), kita diminta membuat script untuk mengidentifikasi gambar yang sama dari keseluruhan gambar yang sudah didownload. Ketika terindikasi gambar yang sama, gambar tersebut akan dipindahkan ke dalam folder ./duplicate dengan nama duplicate_nomor. Sisanya dipindahkan ke dalam folder ./kenangan dengan nama kenangan_nomor. Script ini sendiri terdapat pada file [soal3_c.sh]().
```bash
mkdir duplicate
mkdir kenangan

readarray arr < location.log

num=0

for ((i=0; i<${#arr[@]}; i++))
do
    for ((j=i+1; j<=${#arr[@]}; j++))
    do
        if [ "${arr[$i]}" = "${arr[$j]}" ]
        then
            mv pdkt_kusuma_"$(($j+1))".jpg duplicate/duplicate_"$((num+=1))".jpg
        fi
    done
done

angka=0

for ((i=1; i<=${#arr[@]}; i++))
do
    file=pdkt_kusuma_"$i".jpg
    if [ -f "$file" ]
    then
        mv "$file" kenangan/kenangan_"$((angka+=1))".jpg
    fi
done

cp wget.log wget.log.bak
```
+ `mkdir duplicate` dan `mkdir kenangan` untuk membuat folder dengan nama duplicate dan kenangan.
+ `num=0` inisialisasi variabel num yang menampung penomoran file duplicate.
+ `angka=0` inisialisasi variabel angka yang menampung penomoran file kenangan.
+ `cp wget.log wget.log.bak` menyalin isi dari wget.log ke wget.log.bak.

Dua iterasi berikut dilakukan untuk mengecek apakah terdapat gambar yang sama atau tidak selama variabel i maupun j kurang dari `${#arr[@]}` yang menunjukkan size dari array arr. Jika terdapat gambar yang sama(`${arr[$i]}" = "${arr[$j]}`) maka nama file yang awalnya pdkt_kusuma_nomor.jpg berubah menjadi duplicate_nomor.jpg dan dipindah ke folder duplicate.
```bash
for ((i=0; i<${#arr[@]}; i++))
do
    for ((j=i+1; j<=${#arr[@]}; j++))
    do
        if [ "${arr[$i]}" = "${arr[$j]}" ]
        then
            mv pdkt_kusuma_"$(($j+1))".jpg duplicate/duplicate_"$((num+=1))".jpg
        fi
    done
done
```

Iterasi selanjutnya dilakukan untuk memindahkan file yang sudah diseleksi ke folder kenangan dan mengganti nama file tersebut dengan kenangan_nomor.jpg. Adapun `if [ -f "$file" ]` berfungsi untuk mengecek apakah nama file pdkt_kusuma_nomor.jpg masih ada atau tidak karena pada iterasi sebelumnya, apabila terdapat gambar yang sama, maka gambar tersebut akan diganti namanya dan dipindah ke folder duplicate.
```bash
for ((i=1; i<=${#arr[@]}; i++))
do
    file=pdkt_kusuma_"$i".jpg
    if [ -f "$file" ]
    then
        mv "$file" kenangan/kenangan_"$((angka+=1))".jpg
    fi
done
```
