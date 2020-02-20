# SoalShiftSISOP20_modul1_E02

## Soal 2
Pada suatu siang, laptop Randolf dan Afairuzr dibajak oleh seseorang dan kehilangan data-data penting. Untuk mencegah kejadian yang sama terulang kembali mereka meminta bantuan kepada Whits karena dia adalah seorang yang punya banyak ide. Whits memikirkan sebuah ide namun dia meminta bantuan kalian kembali agar ide tersebut cepat diselesaikan. Idenya adalah kalian (a) membuat sebuah script bash yang dapat menghasilkan password secara acak sebanyak 28 karakter yang terdapat huruf besar, huruf kecil, dan angka. (b) Password acak tersebut disimpan pada file berekstensi .txt dengan nama berdasarkan argumen yang diinputkan dan ​ HANYA ​ berupa alphabet​ . (c) Kemudian supaya file .txt tersebut tidak mudah diketahui maka nama filenya akan di enkripsi dengan menggunakan konversi huruf (string manipulation) yang disesuaikan dengan jam(0-23) dibuatnya file tersebut dengan program terpisah dengan (misal: password.txt dibuat pada jam 01.28 maka namanya berubah menjadi qbttxpse.txt dengan perintah ‘​ bash soal2_enkripsi.sh password.txt’. Karena p adalah huruf ke 16 dan file dibuat pada jam 1 maka 16+1=17 dan huruf ke 17 adalah q dan begitu pula
seterusnya. Apabila melebihi ​ z ​ , akan kembali ke ​ a ​ , contoh: huruf ​ w dengan jam 5.28, maka akan menjadi huruf ​ b.​ ) dan (d) jangan lupa untuk membuat dekripsinya supaya nama file bisa kembali.
### Penyelesaian
Berikut merupakan script bash yang dapat menghasilkan random password sebanyak 28 karakter dengan huruf besar, huruf kecil, dan angka.
```bash
cat /dev/urandom | tr -dc A-Za-z0-9 | head -c 28 > $*.txt
```
Adapun penjelasan dari script bash tersebut:
+ `cat /dev/urandom` menampilkan bagian awal dari /dev/urandom
+ `tr -dc A-Za-z0-9` digunakan agar yang tersisa hanya huruf besar, huruf kecil, dan angka dari output perintah sebelumnya
+ `head -c 28 > $*.txt` digunakan untuk mengambil 28 karakter pertama dari output perintah sebelumnya dan mengirimkan hasilnya ke file .txt dengan nama berdasarkan argumen yang diinputkan.

Agar nama file .txt hanya berupa alphabet maka dilakukan pengecekan dan penghapus karakter selain alphabet dengan script berikut.
```
file="$(echo $* | sed 's/[^A-Za-z]*//g')"
namafile="${file%txt}"
```
+ `echo $*` menampilkan argumen yang diinputkan.
+ `sed 's/[^A-Za-z]*//g'` digunakan agar yang tersisa dari output sebelumnya hanya alphabet.
+ `namafile="${file%txt}"` digunakan untuk memisahkan nama file dari extensinya.
