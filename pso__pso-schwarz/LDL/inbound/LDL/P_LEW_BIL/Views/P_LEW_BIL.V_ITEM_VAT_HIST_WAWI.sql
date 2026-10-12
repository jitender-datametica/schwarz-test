CREATE OR REPLACE VIEW P_LEW_BIL.V_ITEM_VAT_HIST_WAWI as
   /*	
   DescStart	
   $Revision: 6761 $, $LastChangedBy: hwieber $	
   SubjectAreas: Artikelstamm	
   DescEnd	
   */	
   SELECT	
     w.client_id,	
   w.item_sid,	
   Cast(NULL AS VARCHAR(3)) AS country_pol_cd,	
   w.vat_id,	
   h.pct_vat AS vat_value,	
   h.vat_desc AS vat_descr,	
   CASE WHEN h.dat_rec_start > w.dat_rec_start THEN h.dat_rec_start ELSE w.dat_rec_start END AS dwh_valid_from,	
   CASE WHEN h.dat_rec_end < w.dat_rec_end THEN h.dat_rec_end ELSE w.dat_rec_end END AS dwh_valid_to	
  FROM p_lew_core_ac.v_wawi_itm_item w	
   LEFT JOIN (	
   SELECT	
     a.client_id,	
   a.vat_id,	
   a.pct_vat,	
   a.vat_desc,	
   a.dat_rec_start,	
   a.dat_rec_end	
  FROM p_lew_core_ac.v_wawi_ref_wawi_vat_values a	
	
   UNION ALL	
	
   SELECT	
     a.client_id,	
   a.vat_id,	
   a.pct_vat,	
   a.vat_desc,	
   a.dat_rec_start,	
   b.dat_rec_start-1 AS dat_rec_end	
  FROM p_lew_core_ac.v_wawi_ref_vat a	
   INNER JOIN p_lew_core_ac.v_wawi_ref_wawi_vat_values b	
   ON b.client_id = a.client_id	
   AND b.vat_id = a.vat_id	
   AND b.dat_rec_start BETWEEN a.dat_rec_start+1 AND a.dat_rec_end	
   LEFT JOIN p_lew_core_ac.v_wawi_ref_wawi_vat_values c	
   ON c.client_id = b.client_id	
   AND c.vat_id = b.vat_id	
   AND c.dat_rec_start BETWEEN a.dat_rec_start+1 AND b.dat_rec_start - 1	
   WHERE a.client_id NOT IN(SELECT client_id FROM p_lew_core_ac.v_wawi_ref_wawi_vat_values WHERE vat_id > 0)	
   AND language_id = 7	
   AND c.client_id IS NULL	
	
   UNION ALL	
	
   SELECT	
     a.client_id,	
   a.vat_id,	
   a.pct_vat,	
   a.vat_desc,	
   b.dat_rec_end+1 AS dat_rec_start,	
   CASE WHEN c.dat_rec_start-1 < a.dat_rec_end THEN c.dat_rec_start-1 ELSE a.dat_rec_end END AS dat_rec_end	
  FROM p_lew_core_ac.v_wawi_ref_vat a	
   INNER JOIN p_lew_core_ac.v_wawi_ref_wawi_vat_values b	
   ON b.client_id = a.client_id	
   AND b.vat_id = a.vat_id	
   AND b.dat_rec_end BETWEEN a.dat_rec_start AND a.dat_rec_end - 1	
   LEFT JOIN p_lew_core_ac.v_wawi_ref_wawi_vat_values c	
   ON c.client_id = b.client_id	
   AND c.vat_id = b.vat_id	
   AND c.dat_rec_start > b.dat_rec_start	
   LEFT JOIN p_lew_core_ac.v_wawi_ref_wawi_vat_values d	
   ON d.client_id = c.client_id	
   AND d.vat_id = c.vat_id	
   AND d.dat_rec_start BETWEEN b.dat_rec_start AND c.dat_rec_start	
   WHERE a.client_id NOT IN(SELECT client_id FROM p_lew_core_ac.v_wawi_ref_wawi_vat_values WHERE vat_id > 0)	
   AND language_id = 7	
   AND d.client_id IS NULL	
	
   UNION ALL	
	
   SELECT	
     a.client_id,	
   a.vat_id,	
   a.pct_vat,	
   a.vat_desc,	
   a.dat_rec_start,	
   a.dat_rec_end	
  FROM p_lew_core_ac.v_wawi_ref_vat a	
   LEFT JOIN p_lew_core_ac.v_wawi_ref_wawi_vat_values b	
   ON b.client_id = a.client_id	
   AND b.vat_id = a.vat_id	
   AND b.dat_rec_end >= a.dat_rec_start	
   AND b.dat_rec_start <= a.dat_rec_end	
   WHERE a.client_id NOT IN(SELECT client_id FROM p_lew_core_ac.v_wawi_ref_wawi_vat_values WHERE vat_id > 0)	
   AND language_id = 7 -- Duplikate aufgrund der Mehrsprachigkeit verhindern	
   AND b.client_id IS NULL	
   ) h	
   ON h.client_id = w.client_id	
   AND h.vat_id = w.vat_id	
   AND h.dat_rec_start <= w.dat_rec_end	
   AND h.dat_rec_end >= w.dat_rec_start	
;