# Ted Project

### 1. 목적

* TED Talks 데이터 분석을 통해 강연을 성공적으로 이끄는 방법을 제시하고자 함


### 2. 데이터 셋 

1. **Kaggle** dataset

   **https://www.kaggle.com/rounakbanik/ted-talks**

   - dataset list & column names

     | ted_main.csv       | transcripts.csv |
     | :----------------- | --------------- |
     | comments           | transcript      |
     | description        | url             |
     | duration           |                 |
     | event              |                 |
     | film_date          |                 |
     | languages          |                 |
     | main_speaker       |                 |
     | name               |                 |
     | num_speaker        |                 |
     | published_date     |                 |
     | ratings            |                 |
     | related_talks      |                 |
     | speaker_occupation |                 |
     | tags               |                 |
     | title              |                 |
     | url                |                 |
     | views              |                 |

2. Create **New** Dataset

   * new data set & column names

     | top_rating_added_TED_main.csv            | finalscriptSet.csv    |
     | ---------------------------------------- | --------------------- |
     | title                                    | *title*               |
     | main_speaker                             | *description*         |
     | **new_views**                            | *tags*                |
     | **published_date**                       | ***transcript***      |
     | description                              | **laughter**          |
     | speaker_occupation                       | **applause**          |
     | num_speaker                              | **words**             |
     | duration                                 | **sentences**         |
     | comments                                 | **opening_sentences** |
     | tags                                     | **final_sentences**   |
     | languages                                | **music**             |
     | url                                      | **video**             |
     | **funny**                                |                       |
     | **(other rating columns(+13))**... and so on |                       |
     | **top_rating**                           |                       |
     | **bottom_rating**                        |                       |
     |                                          |                       |

     * bold : 새로 만든 변수
     * italic : 데이터 셋의 merge를 통해 생성된 컬럼들

   ​

### 3. 프로젝트 진행상황

* 데이터 전처리

  * ~~유투브크롤링. 직업분류.~~

  > top_rating_added_TED_main.csv  변수 설명

  * published_date : Unix timestamp형인 타입을 date타입으로 변경

  * ratings : json형식으로 한 셀에 모든 rating이 모여있어 각 rating 별 컬럼 생성 

  * new_views : 영상이 올려진 날짜

  * top_rating & bottome_rating

    ​

  > finalscriptSet.csv 변수 설명

  * transcript : (Laughter) & (Applause) 등을 제거한 df 
  * laughter & applause : transcript에 등장한  웃음과 박수의 수
  * words & sentences : transcript에 있는 총 문장 수(. 기준) & 단어 수(' ' 기준)
  * opening_sentences & final_sentences : 시작 두 문장과 마지막 두 문장
  * music & video : 강연에 음악과 영상을 사용하였는지의 유무


* 제안 발표 (11.30)

* 주제의 방향성 확실히 잡기

  * Why **TED**?

  * What is **TED**?

  * What we want? (base on **TED** data) :: 변수 생성

    `어떻게 하면 강의를 잘할 수 있는지 비법 전수`

    1. 강연자가 정하는 **강연주제**에 따라서 어떤 단어들을 많이 사용하면 좋을지

       (ex: 주제별 (Informative, Interesting...) 어떤 단어들이 많이 사용했는지 보여주기)

    2. 강연 영상을 시청한 후, 선정된 **가장 많은 or 적은 Rating**은 어떤 것인지

    3. 강연의 **시작 문장과 마지막 문장**은 어떤 문장을 사용하면 좋을지

    4. 강연이 진행되는 동안 **사용된 문장과 단어의 수** 등은 어떻게 조절하면 좋을지

    5. 강연 중 **웃음과 박수의 포인트**는 어느 부분에 발생하는지

    6. ...

    7. 또 뭐할까?

* If possible

  * 재미요소 : 대통령 or 유명인의 강의 데이터를 가지고 평가해보기

* Oven을 통한 웹 프로토 타입 : https://goo.gl/uxMgou





TEST FOR MARKDOWN

==HIGHLIGHT==

<mark>ggg</mark>

<hr>

---

