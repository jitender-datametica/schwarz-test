CREATE OR REPLACE VIEW P_LEW_MART_LEAD.V_ITEM_PRPTY_LKUP_2

(
  item_prpty_sid
, item_prpty_name_AT
, item_prpty_name_BE
, item_prpty_name_BE_FR
, item_prpty_name_BG
, item_prpty_name_CH
, item_prpty_name_CY
, item_prpty_name_CZ
, item_prpty_name
, item_prpty_name_DK
, item_prpty_name_EE
, item_prpty_name_ES
, item_prpty_name_FI
, item_prpty_name_FR
, item_prpty_name_GB
, item_prpty_name_GR
, item_prpty_name_HR
, item_prpty_name_HU
, item_prpty_name_IE
, item_prpty_name_IT
, item_prpty_name_LT
, item_prpty_name_LV
, item_prpty_name_NI
, item_prpty_name_NL
, item_prpty_name_DE
, item_prpty_name_PL
, item_prpty_name_PT
, item_prpty_name_RO
, item_prpty_name_SE
, item_prpty_name_SI
, item_prpty_name_SK
, item_prpty_name_TR
, item_prpty_name_CS
, item_prpty_name_MT
, item_prpty_name_US
, item_prpty_name_RS
)
AS

   /*
   #DescStart#
   #$Revision: 14120 $, $LastChangedBy: mmalinowski $
   #SubjectAreas#: Access Layer
   #DescEnd#
   */
   SELECT
     item_property_sid
   , CASE WHEN client_id = 1  THEN item_property_local_name ELSE NULL END AS item_prpty_name_expr_AT
   , CASE WHEN client_id = 2  THEN item_property_local_name ELSE NULL END AS item_prpty_name_expr_BE
   , CASE WHEN client_id = 2  THEN item_property_local_name ELSE NULL END AS item_prpty_name_expr_BE_FR
   , CASE WHEN client_id = 3  THEN item_property_local_name ELSE NULL END AS item_prpty_name_expr_BG
   , CASE WHEN client_id = 4  THEN item_property_local_name ELSE NULL END AS item_prpty_name_expr_CH
   , CASE WHEN client_id = 5  THEN item_property_local_name ELSE NULL END AS item_prpty_name_expr_CY
   , CASE WHEN client_id = 6  THEN item_property_local_name ELSE NULL END AS item_prpty_name_expr_CZ
   , COALESCE(item_property_int_name, item_property_cd)                   AS item_prpty_name_expr
   , CASE WHEN client_id = 8  THEN item_property_local_name ELSE NULL END AS item_prpty_name_expr_DK
   , CASE WHEN client_id = 9  THEN item_property_local_name ELSE NULL END AS item_prpty_name_expr_EE
   , CASE WHEN client_id = 10 THEN item_property_local_name ELSE NULL END AS item_prpty_name_expr_ES
   , CASE WHEN client_id = 11 THEN item_property_local_name ELSE NULL END AS item_prpty_name_expr_FI
   , CASE WHEN client_id = 12 THEN item_property_local_name ELSE NULL END AS item_prpty_name_expr_FR
   , CASE WHEN client_id = 13 THEN item_property_local_name ELSE NULL END AS item_prpty_name_expr_GB
   , CASE WHEN client_id = 14 THEN item_property_local_name ELSE NULL END AS item_prpty_name_expr_GR
   , CASE WHEN client_id = 15 THEN item_property_local_name ELSE NULL END AS item_prpty_name_expr_HR
   , CASE WHEN client_id = 16 THEN item_property_local_name ELSE NULL END AS item_prpty_name_expr_HU
   , CASE WHEN client_id = 17 THEN item_property_local_name ELSE NULL END AS item_prpty_name_expr_IE
   , CASE WHEN client_id = 18 THEN item_property_local_name ELSE NULL END AS item_prpty_name_expr_IT
   , CASE WHEN client_id = 19 THEN item_property_local_name ELSE NULL END AS item_prpty_name_expr_LT
   , CASE WHEN client_id = 20 THEN item_property_local_name ELSE NULL END AS item_prpty_name_expr_LV
   , CASE WHEN client_id = 21 THEN item_property_local_name ELSE NULL END AS item_prpty_name_expr_NI
   , CASE WHEN client_id = 22 THEN item_property_local_name ELSE NULL END AS item_prpty_name_expr_NL
   , CASE WHEN client_id = 23 THEN item_property_local_name ELSE NULL END AS item_prpty_name_expr_DE
   , CASE WHEN client_id = 24 THEN item_property_local_name ELSE NULL END AS item_prpty_name_expr_PL
   , CASE WHEN client_id = 25 THEN item_property_local_name ELSE NULL END AS item_prpty_name_expr_PT
   , CASE WHEN client_id = 26 THEN item_property_local_name ELSE NULL END AS item_prpty_name_expr_RO
   , CASE WHEN client_id = 27 THEN item_property_local_name ELSE NULL END AS item_prpty_name_expr_SE
   , CASE WHEN client_id = 28 THEN item_property_local_name ELSE NULL END AS item_prpty_name_expr_SI
   , CASE WHEN client_id = 29 THEN item_property_local_name ELSE NULL END AS item_prpty_name_expr_SK
   , CASE WHEN client_id = 30 THEN item_property_local_name ELSE NULL END AS item_prpty_name_expr_TR
   , CASE WHEN client_id = 31 THEN item_property_local_name ELSE NULL END AS item_prpty_name_expr_CS
   , CASE WHEN client_id = 32 THEN item_property_local_name ELSE NULL END AS item_prpty_name_expr_MT
   , CASE WHEN client_id = 33 THEN item_property_local_name ELSE NULL END AS item_prpty_name_expr_US
   , CASE WHEN client_id = 34 THEN item_property_local_name ELSE NULL END AS item_prpty_name_expr_RS
   FROM p_lew_core_ac.v_item_property_2

   UNION
   SELECT
     -1 AS item_prpty_sid
   , 'Artikel_2 ohne Artikelmerkmale' AS item_prpty_name_AT
   , 'Artikel_2 ohne Artikelmerkmale' AS item_prpty_name_BE
   , 'Article sans caractéristiques' AS item_prpty_name_BE_FR
   , 'Артикул без описание' AS item_prpty_name_BG
   , 'Artikel_2 ohne Artikelmerkmale' AS item_prpty_name_CH
   , 'Κωδικός χωρίς χαρακτηριστικά προϊόντος' AS item_prpty_name_CY
   , 'Artikl bez příznaků' AS item_prpty_name_CZ
   , 'Artikel_2 ohne Artikelmerkmale' AS item_prpty_name
   , 'Vare uden produktegenskab' AS item_prpty_name_DK
   , 'Artiklid ilma tooteomadusteta' AS item_prpty_name_EE
   , 'Art_2ículos sin característica de art_2ículo' AS item_prpty_name_ES
   , 'Tuote ilman Artikelmerkmalea' AS item_prpty_name_FI
   , 'Article sans caractéristiques' AS item_prpty_name_FR
   , 'Item_2 without item_2 characteristics' AS item_prpty_name_GB
   , 'Κωδικός χωρίς χαρακτηριστικά προϊόντος' AS item_prpty_name_GR
   , 'Proizvod bez obilježja proizvoda' AS item_prpty_name_HR
   , 'Termékjellemző nélküli termék' AS item_prpty_name_HU
   , 'Article without characteristics' AS item_prpty_name_IE
   , 'Articolo senza caratteristica' AS item_prpty_name_IT
   , 'Prekės be prekės žymos' AS item_prpty_name_LT
   , 'Prece bez preces apraksta' AS item_prpty_name_LV
   , 'Article without characteristics' AS item_prpty_name_NI
   , 'Artikel_2 zonder artikelkenmerk' AS item_prpty_name_NL
   , 'Artikel_2 ohne Artikelmerkmale' AS item_prpty_name_DE
   , 'Artykuł bez właściwości artykułu' AS item_prpty_name_PL
   , 'Artikel_2 ohne Artikelmerkmale' AS item_prpty_name_PT
   , 'Articole fara atribute' AS item_prpty_name_RO
   , 'Artikel_2 utan Artikelegenskap' AS item_prpty_name_SE
   , 'Artikel_2 brez značilnosti' AS item_prpty_name_SI
   , 'Artikle bez artiklových špecifík' AS item_prpty_name_SK
   , 'Artikel_2 ohne Artikelmerkmale' AS item_prpty_name_TR
   , 'Art_2ículos sin característica de art_2ículo' AS item_prpty_name_CS
   , 'Articolo senza caratteristica' AS item_prpty_name_MT
   , 'Items without item_2 attributes' AS item_prpty_name_US
   , 'Artikal bez karakteristika artikla' AS item_prpty_name_RS
   FROM p_lew_core_ac.v_cal_calendarday_2

  WHERE cal_dt = CURRENT_DATE
;