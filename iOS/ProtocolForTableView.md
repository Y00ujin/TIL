## **UITableView**
<br>

##### **๐  TableView ๋ฅผ ์ํ Protocol**
***
###### UITableView ๋ฅผ ์ํ Protocol ์ **UITableViewDataSource**, **UITableViewDelegate** ๊ฐ ์๋ค. <br> ์ฌ๊ธฐ์ Protocol ์ TableView๋ฅผ ์ด์ฉํ๊ธฐ ์ํด ํด์ผํ  ์ผ๋ค์ ๋ชฉ๋ก, ์ฆ ๊ตฌํํด์ผํ  method ๋ค์ด๋ค. 

<br>

- ###### ```protocol``` ์ค์๋ ํด๋์ค๊ฐ ์์์ ํ๋ฏ์ด ์์ฑํด์ค๋ ๋์ง๋ง,

```Swift
class EZYLISTViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
}
```

- ###### ๋์ค์ ์ฝ๋๊ฐ ๋ง์ ๋ณต์กํด์ง ๊ฒฝ์ฐ๋ฅผ ์ํด ```extension```์ ํตํด ๋ฐ๋ก ๋นผ์ค๋ ๋๋ค.
```Swift
extension EZYLISTViewController: UITableViewDataSource{
}

extension EZYLISTViewController: UITableViewDelegate{
    
}
```


<br>

##### **๐  UITableViewDataSource**

***

##### TableView ๋ฅผ ์ด์ฉํ๊ธฐ ์ํด์ UITableViewDataSource์์ ํ์๋ก ๊ตฌํํด์ผ ํ๋ method ๊ฐ ์๋ค.

```Swift
extension EZYLISTViewController: UITableViewDataSource{
}
```

- ###### TableView ์ cell ์ด ๋ช๊ฐ์ธ์ง?
- ###### Table view ๋ฅผ ์ด๋ป๊ฒ ๋ณด์ฌ์ค ๊ฒ์ธ์ง?
 - ###### ```UITableViewDataSource protocol``` ์ ๊ฒฝ์ฐ, ํ์ ๊ตฌํ ํจ์๋ฅผ ์ถ๊ฐํ์ง ์์ผ๋ฉด, ์๋ฌ๊ฐ ๋ฐ์ํ๋ค. <br>Fix ๋ฅผ ๋๋ฅด๋ฉด ์๋์ผ๋ก ์ถ๊ฐํด์ค๋ค.

<br>

###### ํด๋น ์ง๋ฌธ์ ๋ค์ method ๋ฅผ ๊ตฌํํจ์ผ๋ก ๋ต๋ณํ  ์ ์๋ค.

<br>

##### **1. tableView(_:numberOfRowsInSection:)**

```Swift
func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
```

- ###### ํน์  section ์ ํ์ํ  row ์ ๊ฐ์๋ฅผ ๋ฌป๋ method
- ###### return ๊ฐ์ผ๋ก ๋ช ๊ฐ์ ์์ ๋ณด์ฌ์ค์ง์ ๋ํ ๋ต๋ณ์ ๊ตฌํํ๋ฉด ๋๋ค. 
- ###### section ์ ๋ฐ๋ผ ๋ค๋ฅธ ์์ ๊ฐ์๋ฅผ ๋ฐํํ๋๋ก ๊ตฌํํ  ์ ์๋ค. 

<br>

##### **2. tableView(_:cellForRowAt:)**

```Swift
func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
```

- ###### ํน์  ์์น์ ํ์ํ  cell ์ ์์ฒญํ๋ method
- ###### cell ์ ์์ฑํ  ๋, custom cell ์ ์ฌ์ฌ์ฉํ๋ ค๋ฉด dequeueReusableCell(withIdentifier:for:) method ๋ฅผ ์ด์ฉํ๋ค.
- ###### cell ์ ๋ง๋  ํ์, data ๊ฐ๋ค์ ํตํด cell ์ ์์ฑ๋ค์ ์๋ฐ์ดํธํ  ์ ์๋ค.
- ###### return ๊ฐ์ผ๋ก UITableViewCell ์ ์์๋ฐ์ object ๋ฅผ ๋ฐํํด์ผ ํ๋ค. (nil ๋ฐํ์ ์๋ฌ ๋ฐ์)


<br>

##### **๐  UITableViewDelegate**

***

###### Table view delegate object๋ ํด๋น ํ๋กํ ์ฝ์ ์ฑํํ๋ค. <br> Table view ๋ด์ ํด๋ฆญ๋ ์์ ๋งค๋์งํ๊ฑฐ๋, ์น์์ header์ footer ์ค์ , ์์ ์ญ์ ํ๊ฑฐ๋ ์ฌ์ก๋ดํ๊ธฐ ์ํด ์ด์ฉํ๋ค.

<br>

```Swift
extension EZYLISTViewController: UITableViewDelegate{
    
}
```

- ###### custom header ์ footer view ๋ฅผ ๋ง๋ค๊ณ  ๊ด๋ฆฌํ๋ ๊ฒ
- ###### row, header, footer ์ ๋์ด๋ฅผ ์ง์ ํ๋ ๊ฒ
- ###### ๋ ๋์ ์คํฌ๋กค ์ง์์ ์ํด ๋์ด์ ์ถ์ ์น๋ฅผ ์ ๊ณตํ๋ ๊ฒ
- ###### row ์ ๋ค์ฌ์ฐ๊ธฐ ์์ค์ ์ง์ ํ๋ ๊ฒ
- ###### ์ ํ๋ row ์ ๋ํด ์๋ตํ๋ ๊ฒ
- ###### table row ๋ฅผ ์ค์์ดํํ๋ ๋ฑ ์ก์์ ์๋ตํ๋ ๊ฒ
- ###### table content ๋ฅผ ํธ์งํ  ์ ์๋๋ก ์ง์ํ๋ ๊ฒ

<br>

###### ```UITableViewDelegate protocol``` ํ์ ๊ตฌํ method ๊ฐ ์๋ค. ๋ค์์ ์ฃผ๋ก ์์ฑํ๋ method ์ด๋ค.

<br>
 
##### **1. tableView(_didSelectRowAt:)** 
```Swift
optional func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
```

- ###### delegate (๋๋ฆฌ์ธ)์๊ฒ row๊ฐ ์ ํ๋์์์ ์๋ ค์ฃผ๋ ํจ์. 
- ###### ์์ ์ ํํ์ ๋ ์ด๋ป๊ฒ ํ ์ง์ ๋ํด ๊ตฌํํ  ์ ์๋ ํจ์์ด๋ค.

<br>

###### ์์๋ก, ```TableView``` ๊ฐ ```List page``` ์ด๊ณ  ```Detail page``` ๊ฐ ์๋ค๋ฉด ํด๋น ```method``` ์์ ```performSegue``` ๋ฅผ ํธ์ถํด ```Detail page``` ๋ก ๋์ด๊ฐ๋ ์ฝ๋๋ฅผ ์์ฑํ  ์ ์๋ค.

```Swift
extension ListViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("--> \(indexPath.row)")
        performSegue(withIdentifier: "showDetail", sender: indexPath.row)
    }
}
```


<br>
