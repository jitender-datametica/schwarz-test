CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_ART_VORSCHLAGSWERT_PER_2
( art_id,
ausg_menge_einh_id,
dat_bis,
dat_von,
mandant_id,
paletten_faktor_einh_id,
zl_kolli_menge_einh_id,
sortimentslistenart_id
)
AS
   SELECT
  v01.art_id,
   v01.ausg_menge_einh_id,
   v01.dat_bis,
   v01.dat_von,
   v01.mandant_id,
   cast(v01.paletten_faktor_einh_id as char(5)),
   v01.zl_kolli_menge_einh_id,
   v01.sortimentslistenart_id
   FROM dbp_view.v_art_vorschlagswert_per_2 v01
   WHERE
   v01.paletten_faktor_einh_id NOT IN ('X1', 'X2', 'X3', 'X4', 'X5', 'X6', 'X7', 'X8', 'X9') AND
   v01.dat_bis = DATE '9999-12-31'

   UNION

   SELECT
   v02.art_id,
   v02.ausg_menge_einh_id,
   v02.dat_bis,
   v02.dat_von,
   v02.mandant_id,
   CAST(CAST( CASE WHEN ((MOD(CAST((1/v03.umrech_faktor) AS NUMBER(38,5)), 0.1)) < 0.05) THEN (CAST((1.0/v03.umrech_faktor) AS NUMBER(38,5)) - MOD( CAST((1.0/v03.umrech_faktor) AS NUMBER(38,5)), 0.1))  ELSE  ((CAST((1.0/v03.umrech_faktor) AS NUMBER(38,5)) - MOD( CAST((1.0/v03.umrech_faktor) AS NUMBER(38,5)), 0.1) ) + 0.1) END AS INTEGER) AS CHAR(6)) paletten_faktor_einh_id,
   v02.zl_kolli_menge_einh_id,
   v02.sortimentslistenart_id
   FROM dbp_view.v_art_vorschlagswert_per_2 as v02
   INNER JOIN dbp_view.v_art_umrechnung_faktor_per_2 as v03
   ON (v02.art_id = v03.art_id)
   WHERE
   v02.paletten_faktor_einh_id IN ('X1', 'X2', 'X3', 'X4', 'X5', 'X6', 'X7', 'X8', 'X9') AND
   v02.art_id = v03.art_id AND
   v02.mandant_id = v03.mandant_id AND
   v02.paletten_faktor_einh_id = v03.altnv_menge_einh_id AND
   v02.dat_bis = DATE '9999-12-31' AND
   v03.dat_bis = DATE '9999-12-31';