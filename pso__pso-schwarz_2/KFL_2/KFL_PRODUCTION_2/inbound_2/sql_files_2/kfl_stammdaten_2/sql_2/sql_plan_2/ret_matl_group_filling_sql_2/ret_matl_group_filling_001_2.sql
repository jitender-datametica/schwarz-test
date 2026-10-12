UPDATE DBP_ETL.ret_wghier_2
SET name1 = REPLACE(name1,'/1','/O'),
    NODE = REPLACE(NODE,'0261','026O')
WHERE LENGTH(TRIM(name1)) IN (8) AND
    CHARINDEX('/1',name1,1) > 0
;

DROP TABLE IF EXISTS DBP_ETL.wg_hierarchie_denorm_tmp_2;
DROP TABLE IF EXISTS DBP_ETL.wg_hierarchie_zu_per_tmp_2;

CREATE  TABLE DBP_ETL.wg_hierarchie_denorm_tmp_2  (  
  mandant_id BYTEINT NOT NULL,
  node_ber VARCHAR(50) COLLATE 'de-ci', /*Bereich*/
  node_abt VARCHAR(50) COLLATE 'de-ci', /*Abteilung*/
  node_hwg VARCHAR(50) COLLATE 'de-ci', /*Hauptwarengruppe*/
  node_owg VARCHAR(50) COLLATE 'de-ci', /*Oberwarengruppe*/
  node_wg VARCHAR(50) COLLATE 'de-ci',  /*Warengruppe*/
  ber SMALLINT,
  abt_2 SMALLINT,
  hwg SMALLINT,
  owg SMALLINT,
  wg SMALLINT
);

CREATE  TABLE DBP_ETL.wg_hierarchie_zu_per_tmp_2  (
  mandant_id BYTEINT NOT NULL,
  wg_hierarchie_id SMALLINT NOT NULL,
  wg_hierarchie_ebene_id BYTEINT NOT NULL,
  dat_von DATE NOT NULL,
  dat_bis DATE,
  arthiertyp_id BYTEINT NOT NULL,
  wg_hierarchie_mutter_id SMALLINT
);

INSERT INTO DBP_ETL.wg_hierarchie_denorm_tmp_2
(
   mandant_id
  ,node_ber
  ,node_abt
  ,node_hwg
  ,node_owg
  ,node_wg
  ,ber
  ,abt_2
  ,hwg
  ,owg
  ,wg
)
SELECT
   wg.mandant_id 
  ,ber.NODE AS bereich
  ,abt.NODE AS abteilung
  ,hwg.NODE AS hauptwarengruppe
  ,owg.NODE AS oberwarengruppe
  ,wg.NODE  AS warengruppe
  ,SUBSTRING(ber.name1, CHARINDEX('/B',ber.name1,1)+2, 10) AS ber
  ,SUBSTRING(abt.name1, CHARINDEX('/A',abt.name1,1)+2, 10) AS abt_2
  ,SUBSTRING(hwg.name1, CHARINDEX('/H',hwg.name1,1)+2, 10) AS hwg
  ,SUBSTRING(owg.name1, CHARINDEX('/O',owg.name1,1)+2, 10) AS owg
  ,SUBSTRING(wg.name1 , CHARINDEX('/',wg.name1,1) +1, 10) AS wg
FROM DBP_ETL.ret_wghier_2 wg

INNER JOIN DBP_ETL.ret_wghier_2 owg
ON owg.node_type = '0CLASS_NUM'
AND wg.parent_id = owg.id
AND wg.mandant_id = owg.mandant_id

INNER JOIN DBP_ETL.ret_wghier_2 hwg
ON hwg.node_type = '0CLASS_NUM'
AND owg.parent_id = hwg.id
AND owg.mandant_id = hwg.mandant_id

INNER JOIN DBP_ETL.ret_wghier_2 abt_2
ON abt.node_type = '0CLASS_NUM'
  AND hwg.parent_id = abt.id
  AND hwg.mandant_id = abt.mandant_id 

INNER JOIN DBP_ETL.ret_wghier_2 ber
ON ber.node_type = '0CLASS_NUM'
  AND abt.parent_id = ber.id
  AND abt.mandant_id = ber.mandant_id 

WHERE wg.node_type = '0MATL_GROUP'
;

INSERT INTO DBP_ETL.wg_hierarchie_zu_per_tmp_2
(
   mandant_id
  ,wg_hierarchie_id
  ,arthiertyp_id
  ,wg_hierarchie_mutter_id
  ,wg_hierarchie_ebene_id
  ,dat_von
  ,dat_bis
)
SELECT
   mandant_id
  ,wg AS wg_hierarchie_id
  ,10 AS arthiertyp_id 
  , to_number(lpad(to_varchar(owg),4,'100')) AS wg_hierarchie_mutter_id
  ,5 AS wg_hierarchie_ebene_id      --Ebene Warengruppe
  , to_date('1900-01-01','YYYY-MM_2-DD') AS dat_von
  , to_date('9999-12-31','YYYY-MM_2-DD') AS dat_bis
FROM DBP_ETL.wg_hierarchie_denorm_tmp_2
GROUP BY 1, 2, 3, 4, 5, 6, 7
;

INSERT INTO DBP_ETL.wg_hierarchie_zu_per_tmp_2
(
   mandant_id
  ,wg_hierarchie_id
  ,arthiertyp_id
  ,wg_hierarchie_mutter_id
  ,wg_hierarchie_ebene_id
  ,dat_von
  ,dat_bis
)
SELECT
   mandant_id
  ,to_number(lpad(to_varchar(owg),4,'100')) AS wg_hierarchie_mutter_id
  ,10 AS arthiertyp_id              --fuenfstufige SAP WG Hierarchie
  ,hwg AS wg_hierarchie_mutter_id
  ,4 AS wg_hierarchie_ebene_id      --Ebene Oberwarengruppe
  , to_date('1900-01-01','YYYY-MM_2-DD') AS dat_von
  , to_date('9999-12-31','YYYY-MM_2-DD') AS dat_bis
FROM DBP_ETL.wg_hierarchie_denorm_tmp_2
GROUP BY 1, 2, 3, 4, 5, 6, 7
;

INSERT INTO DBP_ETL.wg_hierarchie_zu_per_tmp_2
(
   mandant_id
  ,wg_hierarchie_id
  ,arthiertyp_id
  ,wg_hierarchie_mutter_id
  ,wg_hierarchie_ebene_id
  ,dat_von
  ,dat_bis
)
SELECT
   mandant_id
  ,hwg AS wg_hierarchie_id
  ,10 AS arthiertyp_id              --fuenfstufige SAP WG Hierarchie
  ,abt_2 AS wg_hierarchie_mutter_id
  ,3 AS wg_hierarchie_ebene_id      --Ebene Hauptwarengruppe
  , to_date('1900-01-01','YYYY-MM_2-DD') AS dat_von
  , to_date('9999-12-31','YYYY-MM_2-DD') AS dat_bis
FROM DBP_ETL.wg_hierarchie_denorm_tmp_2
GROUP BY 1, 2, 3, 4, 5, 6, 7
;

INSERT INTO DBP_ETL.wg_hierarchie_zu_per_tmp_2
(
   mandant_id
  ,wg_hierarchie_id
  ,arthiertyp_id
  ,wg_hierarchie_mutter_id
  ,wg_hierarchie_ebene_id
  ,dat_von
  ,dat_bis
)
SELECT
   mandant_id
  ,abt_2 AS wg_hierarchie_id
  ,10 AS arthiertyp_id              --fuenfstufige SAP WG Hierarchie
  ,ber AS wg_hierarchie_mutter_id
  ,2 AS wg_hierarchie_ebene_id      --Ebene Abteilung
  , to_date('1900-01-01','YYYY-MM_2-DD') AS dat_von
  , to_date('9999-12-31','YYYY-MM_2-DD') AS dat_bis
FROM DBP_ETL.wg_hierarchie_denorm_tmp_2
GROUP BY 1, 2, 3, 4, 5, 6, 7
;

INSERT INTO DBP_ETL.wg_hierarchie_zu_per_tmp_2
(
   mandant_id
  ,wg_hierarchie_id
  ,arthiertyp_id
  ,wg_hierarchie_mutter_id
  ,wg_hierarchie_ebene_id
  ,dat_von
  ,dat_bis
)
SELECT
   mandant_id
  ,ber AS wg_hierarchie_id
  ,10 AS arthiertyp_id              --fuenfstufige SAP WG Hierarchie
  ,ber AS wg_hierarchie_mutter_id   --Initialisierung Elternelement bei Rootelementen
  ,1 AS wg_hierarchie_ebene_id      --Ebene Bereich
  , to_date('1900-01-01','YYYY-MM_2-DD') AS dat_von
  , to_date('9999-12-31','YYYY-MM_2-DD') AS dat_bis
FROM DBP_ETL.wg_hierarchie_denorm_tmp_2
GROUP BY 1, 2, 3, 4, 5, 6, 7
;

INSERT INTO DBP_ETL.wg_hierarchie_zu_per_tmp_2
(
   mandant_id
  ,wg_hierarchie_id
  ,arthiertyp_id
  ,wg_hierarchie_mutter_id
  ,wg_hierarchie_ebene_id
  ,dat_von
  ,dat_bis
)
SELECT
   mandant_id
  ,abt_2 AS wg_hierarchie_id
  ,6 AS arthiertyp_id                --zweistufige SAP WG Hierarchie
  ,abt_2 AS wg_hierarchie_mutter_id    --Initialisierung Elternelement bei Rootelementen
  ,2 AS wg_hierarchie_ebene_id       --Ebene Abteilung
  , to_date('1900-01-01','YYYY-MM_2-DD') AS dat_von 
  , to_date('9999-12-31','YYYY-MM_2-DD') AS dat_bis
FROM DBP_ETL.wg_hierarchie_denorm_tmp_2
GROUP BY 1, 2, 3, 4, 5, 6, 7
;

INSERT INTO DBP_ETL.wg_hierarchie_zu_per_tmp_2
(
   mandant_id
  ,wg_hierarchie_id
  ,arthiertyp_id
  ,wg_hierarchie_mutter_id
  ,wg_hierarchie_ebene_id
  ,dat_von
  ,dat_bis
)
SELECT
   mandant_id
  ,wg AS wg_hierarchie_id           --Warengruppe 
  ,6 AS arthiertyp_id               --zweistufige SAP WG Hierarchie
  ,abt_2 AS wg_hierarchie_mutter_id   --Abteilung 
  ,5 AS wg_hierarchie_ebene_id      --Ebene Warengruppe
  , to_date('1900-01-01','YYYY-MM_2-DD') AS dat_von
  , to_date('9999-12-31','YYYY-MM_2-DD') AS dat_bis
FROM DBP_ETL.wg_hierarchie_denorm_tmp_2
GROUP BY 1, 2, 3, 4, 5, 6, 7
;

DELETE FROM DBP_DATA.wg_hierarchie_zu_per_2
WHERE mandant_id IN
  (
    SELECT 
      mandant_id 
    FROM DBP_ETL.wg_hierarchie_zu_per_tmp_2 wg
        
    GROUP BY 1
  )
  AND arthiertyp_id IN (6,10)
  AND wg_hierarchie_id >= 0
;

INSERT INTO DBP_DATA.wg_hierarchie_zu_per_2
(
   mandant_id
  ,wg_hierarchie_id
  ,arthiertyp_id
  ,wg_hierarchie_mutter_id
  ,wg_hierarchie_ebene_id
  ,dat_von
  ,dat_bis
)
SELECT
   mandant_id
  ,wg_hierarchie_id
  ,arthiertyp_id
  ,wg_hierarchie_mutter_id
  ,wg_hierarchie_ebene_id
  ,dat_von
  ,dat_bis
FROM DBP_ETL.wg_hierarchie_zu_per_tmp_2
;
