CREATE OR REPLACE VIEW ldl_p_lew_mart_cs_ac.v_bw_retail_ejr_writeoff_pv_cum_by_2 (client_id, land_2, wgi, uwg,
artikelfamilie, artikelart, waehrung, monat_2, umsatz_ejr_aufgel, abschriften_gesamt_aufgel, preisveraenderung_aufgel) AS
SELECT client_id,
 `land_2 o08 iso-code` AS land_2,
 `wg i05 mis wg id` AS wgi,
 `uwg i04 mis uwg id` AS uwg,
 `artikelfamilie gruppiert i04 artikelfamiliennummer` AS artikelfamilie,
 `artikelart _u0028_hist_u0029_ hi08 id` AS artikelart,
 `waehrung x02 bezeichnung` AS waehrung,
 `monat_2 t05 id` AS monat_2,
 `umsatz ejr aufgel_u002e_` AS umsatz_ejr_aufgel,
 `abschriften_2 gesamt aufgel_u002e_` AS abschriften_gesamt_aufgel,
 `preisveraenderung aufgel_u002e_` AS preisveraenderung_aufgel
FROM ldl_p_lew_mart_cs.v_bw_retail_ejr_writeoff_pv_cum_by_2;