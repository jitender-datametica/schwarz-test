create or replace view LDL_PRODUCTION_CLONE_GOOGLE_20260608_1030.P_LEW_MART_LEAD.V_ESL_REF_PRICE_LABEL_DAMAGE_REASON_1(
	PRICE_LABEL_DAMAGE_REASON_ID,
	PRICE_LABEL_DAMAGE_REASON_DESCR,
	PRICE_LABEL_DAMAGE_REASON_DESCR_AT,
	PRICE_LABEL_DAMAGE_REASON_DESCR_BE,
	PRICE_LABEL_DAMAGE_REASON_DESCR_BE_FR,
	PRICE_LABEL_DAMAGE_REASON_DESCR_BG,
	PRICE_LABEL_DAMAGE_REASON_DESCR_CH,
	PRICE_LABEL_DAMAGE_REASON_DESCR_CY,
	PRICE_LABEL_DAMAGE_REASON_DESCR_CZ,
	PRICE_LABEL_DAMAGE_REASON_DESCR_DK,
	PRICE_LABEL_DAMAGE_REASON_DESCR_EE,
	PRICE_LABEL_DAMAGE_REASON_DESCR_ES,
	PRICE_LABEL_DAMAGE_REASON_DESCR_FI,
	PRICE_LABEL_DAMAGE_REASON_DESCR_FR,
	PRICE_LABEL_DAMAGE_REASON_DESCR_GB,
	PRICE_LABEL_DAMAGE_REASON_DESCR_GR,
	PRICE_LABEL_DAMAGE_REASON_DESCR_HR,
	PRICE_LABEL_DAMAGE_REASON_DESCR_HU,
	PRICE_LABEL_DAMAGE_REASON_DESCR_IE,
	PRICE_LABEL_DAMAGE_REASON_DESCR_IT,
	PRICE_LABEL_DAMAGE_REASON_DESCR_LT,
	PRICE_LABEL_DAMAGE_REASON_DESCR_LV,
	PRICE_LABEL_DAMAGE_REASON_DESCR_NI,
	PRICE_LABEL_DAMAGE_REASON_DESCR_NL,
	PRICE_LABEL_DAMAGE_REASON_DESCR_DE,
	PRICE_LABEL_DAMAGE_REASON_DESCR_PL,
	PRICE_LABEL_DAMAGE_REASON_DESCR_PT,
	PRICE_LABEL_DAMAGE_REASON_DESCR_RO,
	PRICE_LABEL_DAMAGE_REASON_DESCR_SE,
	PRICE_LABEL_DAMAGE_REASON_DESCR_SI,
	PRICE_LABEL_DAMAGE_REASON_DESCR_SK,
	PRICE_LABEL_DAMAGE_REASON_DESCR_CS,
	PRICE_LABEL_DAMAGE_REASON_DESCR_MT,
	PRICE_LABEL_DAMAGE_REASON_DESCR_US,
	PRICE_LABEL_DAMAGE_REASON_DESCR_RS
) as
WITH tmp_translations AS (
  SELECT * FROM ( VALUES


(
  1
,  'Batterie schwach'                          
,  'Batterij bijna leeg'
,  'Слаба батерия'
,  'Batterie schwach'
,  'Χαμηλή μπαταρία'
,  'Slabá baterie'
,  'Lavt batteri'
,  'Aku peaaegu tühi'
,  'Batería baja'
,  'Akku vähissä'
,  'Batterie faible'
,  'Low battery'
,  'Χαμηλή μπαταρία'
,  'Slaba baterija'
,  'Alacsony töltöttség'
,  'Low battery'
,  'Batteria quasi scarica'
,  'Žemas baterijos įkrovos lygis'
,  'Zems baterijas līmenis'
,  'Low battery'
,  'Lage batterijspanning'
,  'Batterie schwach'                          
,  'Słaba bateria'
,  'Bateria fraca'
,  'Baterie descărcată'
,  'Dåligt batteri'
,  'Skoraj prazna baterija'
,  'Slabá batéria'
,  'Slabá baterie'
,  'Low battery'
,  'Low battery'
,  'Slaba baterija'
)

,(
  2
,  'Display defekt'                           
,   'Scherm beschadigd'
,  'Повреден дисплей на ЕЦТ'
,  'Display defekt'                            
,  'Κατεστραμμένη οθόνη'
,  'Poškozený displej'
,  'Skærmfejl'
,  'Ekraani defekt'
,  'Defecto de pantalla'
,  'Visuaalinen vaurio'
,  'Défaut d''affichage'
,  'Ticket visually damaged'
,  'Βλάβη οθόνης'
,  'Greška zaslona'
,  'Sérült/törött kijelző'
,  'Ticket visually damaged'
,  'CP difettoso'
,  'Ekrano defektas'
,  'Ekrāna defekts'
,  'Ticket visually damaged'
,  'Display defect'
,  'Display defekt'                           
,   'Wada wyświetlacza'
,  'Defeito visível'
,  'Display defect'
,  'Trasig display'
,  'Okvara zaslona'
,  'Poškodený displej (defekt)'
,  'Poškozený displej'
,  'Display defect'
,  'Display defect'
,  'Oštećen ekran'
)

,(
  3
,  'Kein Empfang'                              
,  'Label buiten bereik'
,  'ЕЦТ е извън обхват'
,  'Kein Empfang'                              
,  'Ετικέτα εκτός εμβέλειας'
,  'Štítek mimo dosah signálu'
,  'Etiket uden for modtagelsesområde'
,  'Silt levialast väljas'
,  'Etiqueta fuera de rango de recepción'
,  'Yhteys katkennut'
,  'ESL hors de portée'
,  'Ticket out of signal range'
,  'Εκτός εμβέλειας'
,  'Oznaka van dometa'
,  'Ártábla hálózati kapcsolat nélkül'
,  'Ticket out of signal range'
,  'CP fuori dal raggio di ricezione'
,  'Kainolapis ne ryšio zonoje'
,  'Nav savienojuma'
,  'Ticket out of signal range'
,  'Label buiten Empfangsbereich'
,  'Kein Empfang'                              
,  'Etykieta poza zasięgiem'
,  'Preçário sem rede'
,  'Etichetă fără semnal'
,  'Skylt utanför täckningsområdet'
,  'Cenovni izkaz izven dosega signala'
,  'Žiadny signál'
,  'Štítek mimo dosah signálu'
,  'Label out of range'
,  'Label out of range'
,  'Oznaka van dometa'
)

,(
  4
,  'Defekt bei Ankunft'                        
,  'Defect bij levering'
,  'Дефектна при доставка'
,  'Defekt bei Ankunft'                        
,  'Ελαττωματική κατά την παραλαβή'
,  'Nefunkční při dodání'
,  'Død ved ankomst'
,  'Defektne silt saabumisel'
,  'No funcionaba al llegar'
,  'Viallinen saapumiserä'
,  'Défectueuse à la réception'
,  'Dead on arrival'
,  'Παρελήφθη ελαττωματική'
,  'Neispravno po isporuci'
,  'Defektes érkezés'
,  'Dead on arrival'
,  'CP guasto all''arrivo'
,  'Kainolapis niekada neveikė'
,  'Bojāts piegādes brīdī'
,  'Dead on arrival'
,  'Defect bij ontvangst'
,  'Defekt bei Ankunft'                        
,  'Etykieta uszkodzona w dostawie'
,  'Danificado de fábrica'
,  'Defect din fabrică'
,  'Trasig vid ankomst'
,  'Okvarjeno ob prihodu'
,  'Nefunkčné pri dodaní'
,  'Nefunkční při dodání'
,  'Dead on arrival'
,  'Dead on arrival'
,  'Neispravna dostavljena'
)

,(
  5
,  'Batterie leer'                             
,  'Batterij leeg'
,  'Празна батерия'
,  'Batterie leer'                             
,  'Άδεια μπαταρία'
,  'Vybitá baterie'
,  'Tomt batteri'
,  'Aku tühi'
,  'Batería vacía'
,  'Akku tyhjä'
,  'Batterie vide'
,  'Dead battery'
,  'Άδεια μπαταρία'
,  'Prazna baterija'
,  'Lemerült akkumulátor'
,  'Dead battery'
,  'Batteria scarica'
,  'Tuščia baterija'
,  'Tukša baterija'
,  'Dead battery'
,  'Lege batterij'
,  'Batterie leer'                            
,  'Bateria wyczerpana'
,  'Sem bateria'
,  'Baterie epuizată'
,  'Tomt batteri'
,  'Prazna baterija'
,  'Vybitá batéria'
,  'Vybitá baterie'
,  'Battery empty'
,  'Battery empty'
,  'Prazna baterija'
)


,(
  6
,  'Displaybruch in ESL Lagerorga'             
,  'Scherm beschadigd tijdens vullen'
,  'Счупване на табела при зареждане на стока или от клиент'
,  'Displaybruch in ESL Lagerorga'             
,  'Θραύση οθόνης κατά την τοποθέτηση προϊόντων'
,  'Rozbito při doplňování zboží'
,  'Skærmbrud under vareopfyldning'
,  'Ekraani purunemine laoriiulil'
,  'Rotura de pantalla en balda'
,  'Hintakyltti rikkoutunut hyllytyksen yhteydessä'
,  'Casse lors de la mise en rayon'
,  'Ticket damaged working stock'
,  'Θραύση (φόρτωμα)'
,  'Oštećen ekran prilikom slaganja'
,  'Törés vásárló által/árutöltés során'
,  'Ticket damaged working stock'
,  'Rottura del CP durante il commissionamento'
,  'Ekranas sulūžo dedant prekes į lentyną'
,  'Bojājums krāmējot plauktus'
,  'Ticket damaged working stock'
,  'Breuk tijdens vullen'
,  'Displaybruch in ESL Lagerorga'             
,  'Etykieta uszkodzona w trakcie wykładania towaru'
,  'Ecrã danificado durante reposição de stock'
,  'Display spart în timpul plasării baxului'
,  'Trasig display vid upplock'
,  'Okvara zaslona pri zlaganju blaga'
,  'Poškodená ESL pri dokladaní tovaru'
,  'Rozbito při doplňování zboží'
,  'Label broken during pack out'
,  'Label broken during pack out'
,  'Oznaka oštećena prilikom slaganja robe'
)


,(
  7
,  'Displaybruch bei Anbringung'               
,  'Scherm beschadigd bij montage/verwijdering'
,  'Счупване на табела по време на монтажа'
,  'Displaybruch bei Anbringung'               
,  'Θραύση οθόνης κατά την τοποθέτηση/αφαίρεση'
,  'Rozbito při instalaci/odstranění štítku'
,  'Skærmbrud under montering'
,  'Ekraani purunemine sildi paigaldamisel'
,  'Rotura de pantalla en montaje'
,  'Hintakyltti rikkoutunut kiinnityksen/irrotuksen yhteydessä'
,  'Casse lors de la manipulation à l’implantation'
,  'Ticket damaged installing or removing from strip'
,  'Θραύση (τοποθέτηση)'
,  'Oštećenje zaslona pri postavljanju'
,  'Rottura del CP durante il maneggio'
,  'Ticket damaged installing or removing from strip'
,  'Rottura del CP durante il maneggio'
,  'Ekranas sulūžo įdedant / išimant į / iš lentynos'
,  'Bojājums uzstādīšanas laikā'
,  'Ticket damaged installing or removing from strip'
,  'Breuk tijdens bevestigen'
,  'Displaybruch bei Anbringung'              
,  'Etykieta uszkodzona w trakcie montażu'
,  'Ecrã danificado na colocação/remoção do preçário'
,  'Display spart în momentul montării la raft'
,  'Trasig display vid skyltmontering'
,  'Okvara zaslona pri namestitvi'
,  'Poškodená ESL pri inštalácii/deinštalácii'
,  'Rozbito při instalaci/odstranění štítku'
,  'Label broken during installation or removal from price strip'
,  'Label broken during installation or removal from price strip'
,  'Oznaka oštećena prilikom postavljanja/skidanja'
)


,(
  8
,  'Displaybruch falsche Lagerung'             
,  'Scherm beschadigd door verkeerde opslag'
,  'Счупване на табела при складиране'
,  'Displaybruch falsche Lagerung'             
,  'Θραύση οθόνης λόγω λανθασμένης αποθήκευσης'
,  'Rozbito při skladování'
,  'Skærmbrud under indlagring'
,  'Ekraani purunemine sildi haldamisel'
,  'Rotura de pantalla organización'
,  'Hintakyltti rikkoutunut virheellisen säilytyksen vuoksi'
,  'Casse due à un défaut de stockage'
,  'Ticket damaged due to incorrect storage'
,  'Θραύση (αποθήκευση)'
,  'Oštećenje zaslona - neispravno skladištenje'
,  'Törés helytelen tárolás miatt'
,  'Ticket damaged due to incorrect storage'
,  'Rottura del CP per organizzazione sbagliata'
,  'Kainolapis pažeistas dėl netinkamo sandėliavimo'
,  'Bojājums nepareizas uzglabāšanas rezultātā'
,  'Ticket damaged due to incorrect storage'
,  'Breuk door opslag'
,  'Displaybruch falsche Lagerung'             
,  'Etykieta uszkodzona przez nieprawidłowe przechowywanie'
,  'Ecrã danificado por armazenamento incorreto'
,  'Display spart în momentul depozitării în birou'
,  'Trasig display vid skylthantering'
,  'Okvara zaslona pri skladiščenju'
,  'Poškodená ESL pri nevhodnom uskladnení'
,  'Rozbito při skladování'
,  'The label was damaged because it was stored improperly'
,  'The label was damaged because it was stored improperly'
,  'Oznaka oštećena prilikom skladištenja'
)


,(
  9
,  'Verbindung fehleschlagen'                  
,  'Overdracht mislukt'
,  'Неуспешно свързване'
,  'Verbindung fehleschlagen'                  
,  'Αποτυχία μετάδοσης'
,  'Neúspěšný přenos'
,  'Mislykket transmission'
,  'Ebaõnnestunud edastus'
,  'Transmisión fallida'
,  'Hintakyltti ei linkity tuotteeseen'
,  'Association au code article échouée'
,  'Failed transmission'
,  'Αποτύχια μετάδοσης'
,  'Neuspjeli prijenos'
,  'Sikertelen termék hozzárendelés'
,  'Failed transmission'
,  'Errore di trasmissione'
,  'Kainolapio neina susieti su preke.'
,  'Neizdevās pārraide'
,  'Failed transmission'
,  'Mislukte koppeling'
,  'Verbindung fehleschlagen'                  
,  'Nieudana transmisja - brak reakcji etykiety'
,  'Transmissão falhada na associação de preçário'
,  'Transmisie eșuată'
,  'Misslyckad överföring'
,  'Neuspešna povezava'
,  'Neúspešné párovanie ESL k artiklu'
,  'Neúspěšný přenos'
,  'Failed transmission'
,  'Failed transmission'
,  'Neuspešno povezivanje sa artiklom'
)


,(
  10
,  'Unbekannt'                                 
,  'Onbekende reden'
,  'Неизвестна причина'
,  'Unbekannt'                                 
,  'Άγνωστη αιτία'
,  'Neznámý'
,  'Ukendt'
,  'Tundmatu'
,  'Desconocido'
,  'Vian syy tuntematon'
,  'Inconnu'
,  'Unknown'
,  'Άγνωστη'
,  'Nepoznata greška'
,  'Ismeretlen meghibásodás'
,  'Unknown'
,  'Sconosciuto'
,  'Defekto priežastis nežinoma'
,  'Nezināms'
,  'Unknown'
,  'Onbekend'
,  'Unbekannt'                                 
,  'Uszkodzenie nieznane'
,  'Motivo desconhecido'
,  'Necunoscut'
,  'Okänd defekt anledning'
,  'Neznana okvara'
,  'Neznámy dôvod poškodenia'
,  'Neznámý'
,  'Damage/defect reason is unknown'
,  'Damage/defect reason is unknown'
,  'Nepoznato'
)

) translations (
     PRICE_LABEL_DAMAGE_REASON_ID
    ,PRICE_LABEL_DAMAGE_REASON_DESCR_AT
    ,PRICE_LABEL_DAMAGE_REASON_DESCR_BE
    ,PRICE_LABEL_DAMAGE_REASON_DESCR_BG
    ,PRICE_LABEL_DAMAGE_REASON_DESCR_CH
    ,PRICE_LABEL_DAMAGE_REASON_DESCR_CY
    ,PRICE_LABEL_DAMAGE_REASON_DESCR_CZ
    ,PRICE_LABEL_DAMAGE_REASON_DESCR_DK
    ,PRICE_LABEL_DAMAGE_REASON_DESCR_EE
    ,PRICE_LABEL_DAMAGE_REASON_DESCR_ES
    ,PRICE_LABEL_DAMAGE_REASON_DESCR_FI
    ,PRICE_LABEL_DAMAGE_REASON_DESCR_FR
    ,PRICE_LABEL_DAMAGE_REASON_DESCR_GB
    ,PRICE_LABEL_DAMAGE_REASON_DESCR_GR
    ,PRICE_LABEL_DAMAGE_REASON_DESCR_HR
    ,PRICE_LABEL_DAMAGE_REASON_DESCR_HU
    ,PRICE_LABEL_DAMAGE_REASON_DESCR_IE
    ,PRICE_LABEL_DAMAGE_REASON_DESCR_IT
    ,PRICE_LABEL_DAMAGE_REASON_DESCR_LT
    ,PRICE_LABEL_DAMAGE_REASON_DESCR_LV
    ,PRICE_LABEL_DAMAGE_REASON_DESCR_NI
    ,PRICE_LABEL_DAMAGE_REASON_DESCR_NL
    ,PRICE_LABEL_DAMAGE_REASON_DESCR_DE
    ,PRICE_LABEL_DAMAGE_REASON_DESCR_PL
    ,PRICE_LABEL_DAMAGE_REASON_DESCR_PT
    ,PRICE_LABEL_DAMAGE_REASON_DESCR_RO
    ,PRICE_LABEL_DAMAGE_REASON_DESCR_SE
    ,PRICE_LABEL_DAMAGE_REASON_DESCR_SI
    ,PRICE_LABEL_DAMAGE_REASON_DESCR_SK
    ,PRICE_LABEL_DAMAGE_REASON_DESCR_CS
    ,PRICE_LABEL_DAMAGE_REASON_DESCR_MT
    ,PRICE_LABEL_DAMAGE_REASON_DESCR_US
    ,PRICE_LABEL_DAMAGE_REASON_DESCR_RS
)
)
SELECT 
   base.PRICE_LABEL_DAMAGE_REASON_ID
  ,tr.PRICE_LABEL_DAMAGE_REASON_DESCR_DE              AS PRICE_LABEL_DAMAGE_REASON_DESCR  
  ,tr.PRICE_LABEL_DAMAGE_REASON_DESCR_AT
  ,tr.PRICE_LABEL_DAMAGE_REASON_DESCR_BE
  ,tr.PRICE_LABEL_DAMAGE_REASON_DESCR_FR              AS PRICE_LABEL_DAMAGE_REASON_DESCR_BE_FR
  ,tr.PRICE_LABEL_DAMAGE_REASON_DESCR_BG
  ,tr.PRICE_LABEL_DAMAGE_REASON_DESCR_CH
  ,tr.PRICE_LABEL_DAMAGE_REASON_DESCR_CY
  ,tr.PRICE_LABEL_DAMAGE_REASON_DESCR_CZ
  ,tr.PRICE_LABEL_DAMAGE_REASON_DESCR_DK
  ,tr.PRICE_LABEL_DAMAGE_REASON_DESCR_EE
  ,tr.PRICE_LABEL_DAMAGE_REASON_DESCR_ES
  ,tr.PRICE_LABEL_DAMAGE_REASON_DESCR_FI
  ,tr.PRICE_LABEL_DAMAGE_REASON_DESCR_FR
  ,tr.PRICE_LABEL_DAMAGE_REASON_DESCR_GB
  ,tr.PRICE_LABEL_DAMAGE_REASON_DESCR_GR
  ,tr.PRICE_LABEL_DAMAGE_REASON_DESCR_HR
  ,tr.PRICE_LABEL_DAMAGE_REASON_DESCR_HU
  ,tr.PRICE_LABEL_DAMAGE_REASON_DESCR_IE
  ,tr.PRICE_LABEL_DAMAGE_REASON_DESCR_IT
  ,tr.PRICE_LABEL_DAMAGE_REASON_DESCR_LT
  ,tr.PRICE_LABEL_DAMAGE_REASON_DESCR_LV
  ,tr.PRICE_LABEL_DAMAGE_REASON_DESCR_NI
  ,tr.PRICE_LABEL_DAMAGE_REASON_DESCR_NL
  ,tr.PRICE_LABEL_DAMAGE_REASON_DESCR_DE
  ,tr.PRICE_LABEL_DAMAGE_REASON_DESCR_PL
  ,tr.PRICE_LABEL_DAMAGE_REASON_DESCR_PT
  ,tr.PRICE_LABEL_DAMAGE_REASON_DESCR_RO
  ,tr.PRICE_LABEL_DAMAGE_REASON_DESCR_SE
  ,tr.PRICE_LABEL_DAMAGE_REASON_DESCR_SI
  ,tr.PRICE_LABEL_DAMAGE_REASON_DESCR_SK
  ,tr.PRICE_LABEL_DAMAGE_REASON_DESCR_CS
  ,tr.PRICE_LABEL_DAMAGE_REASON_DESCR_MT
  ,tr.PRICE_LABEL_DAMAGE_REASON_DESCR_US
  ,tr.PRICE_LABEL_DAMAGE_REASON_DESCR_RS
FROM P_LEW_CORE_AC.V_ESL_REF_PRICE_LABEL_DAMAGE_REASON_1 base
LEFT JOIN tmp_translations tr
  ON base.PRICE_LABEL_DAMAGE_REASON_ID = tr.PRICE_LABEL_DAMAGE_REASON_ID;
