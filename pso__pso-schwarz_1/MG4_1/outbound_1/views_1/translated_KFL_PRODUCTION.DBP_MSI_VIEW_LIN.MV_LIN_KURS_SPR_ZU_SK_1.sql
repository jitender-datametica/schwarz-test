-- 03.02.2020 srom0404, AP0052703, SPEC0068452, Ersetzen des Kennzeichen UWL, durch EWL und GSL, UWU entfernen

-- 18.03.2024 twie: SPEC0233542 lin_bericht in CROSS JOIN aufgenommen, da Teil des Schlüssels

CREATE OR REPLACE VIEW dbp_msi_view_lin.mv_lin_kurs_spr_zu_sk_1 (mandant_id, lin_kurs_id, lin_kurs_bez, mandant_kbez) AS
SELECT v1.mandant_id,
 v1.lin_kurs_id,
 v2.lin_kurs_bez,
 v3.mandant_kbez
FROM kfl_production_dbp_view.v_l_lin_kurs_1 AS v1
 INNER JOIN kfl_production_dbp_view.v_lin_kurs_spr_zu_1 AS v2 ON v1.lin_kurs_id = v2.lin_kurs_id
   -- AND v1.mandant_id = v2.mandant_id
 AND v1.lin_bericht = v2.lin_bericht
 INNER JOIN kfl_production_dbp_view.v_mandant_1 AS v3 ON v1.mandant_id = v3.mandant_id
WHERE v2.spr_id = 108
 AND (v1.lin_bericht IN ('EWL', 'GSL') OR v1.lin_bericht IS NULL)
GROUP BY v1.mandant_id,
 v1.lin_kurs_id,
 v2.lin_kurs_bez,
 v3.mandant_kbez;