CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_wewa_2 (mandant_id, wup_id, dat, art_id, wrg_id,
wewa_beleg_pos_id, lager_bewart_id, gp_id, wewa_jahr, wewa_beleg_id, wewa_menge_zl, wewa_menge_dz, wewa_menge_ret_zl,
wewa_menge_ret_dz, wewa_betrag_vk_netto) AS SELECT WEWA.mandant_id,
 WUP.aktuell_wup_id AS wup_id,
 WEWA.dat_buch AS dat,
 WEWA.art_id,
 krs.nach_wrg_id AS wrg_id,
 WEWA.wewa_beleg_pos_id,
 WEWA.lager_bewart_id,
 WEWA.gp_id,
 WEWA.wewa_jahr,
 WEWA.wewa_beleg_id,
 SUM(IF(SAFE_CAST(WEWA.lager_bewart_id as INTEGER) IN (101, 102, 901, 902) AND WEWA.nb_id = - 111, WEWA.menge_basis, 0)
  ) AS wewa_menge_zl,
 SUM(IF(SAFE_CAST(WEWA.lager_bewart_id as INTEGER) IN (101, 102, 901, 902) AND WEWA.nb_id = 0, WEWA.menge_basis, 0)) AS
 wewa_menge_dz,
 SUM(IF(SAFE_CAST(WEWA.lager_bewart_id as INTEGER) IN (101, 102, 901, 902) AND WEWA.nb_id = - 111, WEWA.menge_basis, 0)
  ) AS wewa_menge_ret_dz,
 SUM(IF(SAFE_CAST(WEWA.lager_bewart_id as INTEGER) IN (101, 102, 901, 902) AND WEWA.nb_id = 0, WEWA.menge_basis, 0)) AS
 wewa_menge_ret_dz0,
 IFNULL(SUM(WEWA.betrag_vk_netto), 0) AS wewa_betrag_vk_netto
FROM kfl_production_dbp_view.v_wewa_2 AS WEWA_2
 INNER JOIN kfl_production_dbp_view.v_wup_2 AS WUP_2 ON WEWA.mandant_id = WUP.mandant_id AND WEWA.wup_id = WUP.wup_id
 INNER JOIN (SELECT von_wrg_id,
    nach_wrg_id,
    umrechnungskurs
   FROM kfl_production_dbp_data.kurs_2 AS KRS1
   WHERE kurstyp_id = 3
    AND dat_bis = DATE '9999-12-31'
    AND von_wrg_id NOT IN ('AUD', 'DEM', 'SIT')
   UNION ALL
   SELECT von_wrg_id,
    von_wrg_id AS von_wrg_id0,
    1.0000
   FROM kfl_production_dbp_data.kurs_2 AS KRS2
   WHERE kurstyp_id = 3
    AND dat_bis = DATE '9999-12-31'
    AND von_wrg_id NOT IN ('AUD', 'DEM', 'SIT', 'EUR')) AS krs ON WEWA.wrg_id = krs.von_wrg_id
GROUP BY WEWA.mandant_id,
 wup_id,
 dat,
 WEWA.art_id,
 wrg_id,
 WEWA.wewa_beleg_pos_id,
 WEWA.lager_bewart_id,
 WEWA.gp_id,
 WEWA.wewa_jahr,
 WEWA.wewa_beleg_id;