CREATE OR REPLACE VIEW DBP_MSI_VIEW_IOS.MV_USER_KURS_1 as
   -- ZUORDNUNG/UMRECHNUNG - Ermittlung Kurs_1 aus Usereinstellung
   -- Verwendung in den Faktviews zur Umrechnung von Betraegen
   -- 20160321 ssch0611 : Final
   -- 20160504 ssch0611 : Update, Aliase, Join mit Faktviews

   SELECT DISTINCT
   mandant_id, wrg_typ_id, von_wrg_id, nach_wrg_id, umrechnungskurs, kurs_1              AS kurs_1    -- Kurs_1 fuer Anzeige im Bericht
   , nach_wrg_id       AS wrg_id  -- Waehrung fuer Anzeige im Bericht
   , umrechnungskurs   AS FAKTOR  -- Umrechnungsfaktor fuer Berechnung (ALIAS)
   --, sub01.user_id
   FROM (
   SELECT
   m.mandant_id, w.wrg_typ_id, k.von_wrg_id, k.nach_wrg_id, k.umrechnungskurs AS umrechnungskurs, ROUND( 1 / k.umrechnungskurs,5) AS kurs_1
   --, w.user_id
   FROM
   dbp_view.v_kurs_1 k

   JOIN dbp_msi_v_view.v_user_wrg_typ_zu_1  w
   ON w.wrg_typ_id = 0 -- Umrechnung in EUR

   JOIN dbp_view.v_mandant_1 m
   ON m.default_wrg = k.von_wrg_id

   WHERE k.kurstyp_id = 3 AND k.dat_bis = '9999-12-31' -- -- Berichtskurs (aktuelle Version)

   UNION ALL
   SELECT
   m.mandant_id, w.wrg_typ_id, k.von_wrg_id, k.von_wrg_id AS nach_wrg_id, 1 AS umrechnungskurs, 1 AS kurs_1
   --, w.user_id
   FROM
   dbp_view.v_kurs_1 k

   JOIN dbp_msi_v_view.v_user_wrg_typ_zu_1  w
   ON w.wrg_typ_id = 1 -- Anzeige Landeswaehrung

   JOIN dbp_view.v_mandant_1 m
   ON m.default_wrg = k.von_wrg_id

   WHERE k.kurstyp_id = 3 AND k.dat_bis = '9999-12-31' -- -- Berichtskurs (aktuelle Version)
   ) sub01;