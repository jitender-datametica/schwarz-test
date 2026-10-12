CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_zb.v_kurs_1 (mandant_id, wrg_typ_id, von_wrg_id, nach_wrg_id,
umrechnungskurs, kurs_1, wrg_id, faktor) AS -- Kurs_1 fuer Anzeige im Bericht
 -- Waehrung fuer Anzeige im Bericht

-- Umrechnungsfaktor fuer Berechnung (ALIAS)
 -- , w.user_id
 -- -- Berichtskurs (aktuelle Version)

-- -- Berichtskurs (aktuelle Version)
 SELECT DISTINCT mandant_id,
 wrg_typ_id,
 von_wrg_id,
 nach_wrg_id,
 umrechnungskurs,
 kurs_1,
 nach_wrg_id AS wrg_id,
 umrechnungskurs AS faktor
FROM (SELECT M.mandant_id,
    W.wrg_typ_id,
    K.von_wrg_id,
    K.nach_wrg_id,
    K.umrechnungskurs,
    ROUND(1 / K.umrechnungskurs, 5) AS kurs_1
   FROM kfl_production_dbp_data.kurs_1 AS K
    INNER JOIN kfl_production_dbp_msi_data.user_wrg_typ_zu_1 AS W ON W.wrg_typ_id = 0 -- Umrechnung in EUR

    INNER JOIN kfl_production_dbp_data.mandant_1 AS M ON K.von_wrg_id = M.default_wrg
   WHERE K.kurstyp_id = 3
    AND K.dat_bis = DATE '9999-12-31'
   UNION ALL
   SELECT M.mandant_id,
    W.wrg_typ_id,
    K.von_wrg_id,
    K.von_wrg_id AS nach_wrg_id,
    1 AS umrechnungskurs,
    1 AS kurs_1
   FROM kfl_production_dbp_data.kurs_1 AS K
    INNER JOIN kfl_production_dbp_msi_data.user_wrg_typ_zu_1 AS W ON W.wrg_typ_id = 1 -- Anzeige Landeswaehrung

    INNER JOIN kfl_production_dbp_data.mandant_1 AS M ON K.von_wrg_id = M.default_wrg
   WHERE K.kurstyp_id = 3
    AND K.dat_bis = DATE '9999-12-31') AS sub01;