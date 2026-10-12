CREATE OR REPLACE PROCEDURE dbp_macro.m_vis_kommentar_kennzahlen(p_mandant_id INT64, p_kjmo INT64, p_kommentar_ebene_id INT64, p_kommentar_id INT64, p_kommentar_nr INT64, p_kommentar_thema STRING, p_kommentar_feststellung STRING, p_kommentar_massnahme STRING, p_kommentar_titel STRING, p_kommentar_dat STRING, OUT return_value STRING)
  BEGIN
    /* OWNER does not work */
    DECLARE v_ergebnis STRING DEFAULT 'Kommentare Kennzahlen aktualisiert';
    MERGE INTO kfl_production_dbp_msi_view_vis.ts_vis_kommentar_kennzahlen_1 AS trgt USING (
      SELECT
          p_mandant_id AS mandant_id,
          p_kjmo AS kjmo,
          p_kommentar_ebene_id AS kommentar_ebene_id,
          p_kommentar_id AS kommentar_id,
          p_kommentar_nr AS kommentar_nr,
          p_kommentar_thema AS kommentar_thema,
          p_kommentar_feststellung AS kommentar_feststellung,
          p_kommentar_massnahme AS kommentar_massnahme,
          p_kommentar_titel AS kommentar_titel,
          p_kommentar_dat AS kommentar_dat
    ) AS srce
    ON srce.mandant_id = trgt.mandant_id
     AND srce.kjmo = trgt.kjmo
     AND srce.kommentar_ebene_id = trgt.kommentar_ebene_id
     AND srce.kommentar_id = trgt.kommentar_id
     AND srce.kommentar_nr = trgt.kommentar_nr
       WHEN MATCHED THEN UPDATE SET
        kommentar_thema = srce.kommentar_thema, 
        kommentar_feststellung = srce.kommentar_feststellung, 
        kommentar_massnahme = srce.kommentar_massnahme, 
        kommentar_titel = srce.kommentar_titel, 
        kommentar_dat = CAST(srce.kommentar_dat AS DATE), 
        kommentar_ts = CAST(CURRENT_TIMESTAMP() AS DATETIME)
       WHEN NOT MATCHED BY TARGET THEN
        INSERT (mandant_id, kjmo, kommentar_ebene_id, kommentar_id, kommentar_nr, kommentar_thema, kommentar_feststellung, kommentar_massnahme, kommentar_titel, kommentar_dat, kommentar_ts)
        VALUES (srce.mandant_id, srce.kjmo, srce.kommentar_ebene_id, srce.kommentar_id, srce.kommentar_nr, srce.kommentar_thema, srce.kommentar_feststellung, srce.kommentar_massnahme, srce.kommentar_titel, CAST(srce.kommentar_dat AS DATE), CAST(current_timestamp()AS DATETIME))
    ;
    SET return_value = v_ergebnis;
    RETURN;
  END;
