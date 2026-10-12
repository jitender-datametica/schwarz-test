CREATE OR REPLACE view P_LEW_BIL.V_REF_ITM_EAN as
   -- Mapping-View für EJR Transformation während der Beladung. Grundsätzlich gehört die View damit nach X_LEW_PROCESS, was aber an den Berichtungen scheitert, weshalb diese übergangsweise in X_LEW_BIL existiert.	
   -- Die VIEW ist obsolet, sobald die EJR Transformation abgeschlossen ist und kann anschließend eliminiert werden.	
   SELECT i.client_id,	
   wh.loc_sid_wh,	
   wh.src_wh_id AS wh_id,	
   i.item_sid,	
   Cast(To_Number(Coalesce(i.src_orig_item_nr, i.config_item_cd, i.src_matnr)) AS DECIMAL(18,0)) AS orig_item_nr,	
   iuomh.gtin AS gtin_input_cd,	
   Cast(iuomh.gtin AS DECIMAL(18,0)) AS barcode,	
   CASE WHEN iuomh.conv_to_base_numerator <> 0 AND iuomh.conv_to_base_denominator <> 0	
          THEN iuomh.conv_to_base_numerator / Cast(iuomh.conv_to_base_denominator AS DECIMAL(7,3))	
   ELSE 1	
END AS case_factor_ejr,	
   iuomh.dwh_valid_from,	
   iuomh.dwh_valid_to	
  FROM p_lew_core_ac.v_item AS i	
   INNER JOIN p_lew_core_ac.v_item_unit_of_measurement AS iuom	
   ON i.client_id = iuom.client_id	
   AND i.item_sid = iuom.item_sid	
   INNER JOIN p_lew_core_ac.v_item_unit_of_measurement_hist AS iuomh	
   ON iuom.client_id = iuomh.client_id	
   AND iuom.item_sid = iuomh.item_sid	
   AND iuom.uom_sid = iuomh.uom_sid	
   INNER JOIN p_lew_bil.v_warehouse AS wh	
   ON iuomh.client_id = wh.client_id	
   AND wh.active_fg = 1	
   AND wh.dwh_actual_fg = 1	
   INNER JOIN p_lew_core_ac.v_country AS ctry	
   ON ctry.src_country_lidl_cd = wh.global_loc_ctry_cd	
   INNER JOIN p_lew_core_ac.v_client AS cl	
   ON cl.client_id = wh.client_id	
   AND cl.country_sid = ctry.country_sid	
WHERE Try_To_Number(i.log_var_cd) = 2 -- Nur Verkaufsvarianten	
AND (Coalesce(iuom.log_var_cd, '@') <> '2' OR Length(iuom.uom_cd) > 2) -- no EANs needed in lookup table for base UOMs, but ESB sends the EAN as item number for all three-character UOMs	
AND Try_To_Number(iuomh.gtin) IS NOT NULL -- only numeric GTIN (EAN) barcode values	
AND iuomh.dwh_valid_to >= Add_Months(Current_Date, -12) -- all rows which have been valid during the last year	
AND Cast(iuomh.gtin AS DECIMAL(18,0)) <> Cast(To_Number(Coalesce(i.src_orig_item_nr, i.config_item_cd, i.src_matnr)) AS DECIMAL(18,0)) -- Nur EAN Codes ungleich Artikelnummer	
AND wh.bges_active_fg = 1 --> Nur Beschaffungsgesellschaften	
-- Olap Funktion: maximal 1 Datensatz pro CLIENT, WH und EAN	
QUALIFY Row_Number() Over (	
PARTITION BY i.client_id	
   , wh.src_wh_id	
   , Cast(iuomh.gtin AS DECIMAL(18,0))	
ORDER BY iuomh.dwh_valid_from DESC NULLS LAST	
   , CASE WHEN iuomh.conv_to_base_numerator <> 0 AND iuomh.conv_to_base_denominator <> 0	
       THEN iuomh.conv_to_base_numerator / Cast(iuomh.conv_to_base_denominator AS DECIMAL(7,3))	
   ELSE 1	
END ASC -- kleinster Faktor, Sortierbedingung bei Pflegefehlern nötig	
, i.item_sid ASC	
) = 1	
;