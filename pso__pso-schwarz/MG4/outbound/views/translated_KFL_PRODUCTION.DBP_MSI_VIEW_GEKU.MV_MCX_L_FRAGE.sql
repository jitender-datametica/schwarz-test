-- Eltern von Antwort, keine eindeutige Zuordnung zu Kategorie und Bereich

-- 20180502 twie: SPEC0037245 Neuanlage Lookup Frage in Maritz
 -- 20190404 twie: SPEC0053317 Umfrage im Schlüssel

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_geku.mv_mcx_l_frage (frage_id, umfrage_id, frage_ex_typ, frage_status
) AS SELECT frage_id,
 umfrage_id,
 frage_ex_typ,
 frage_status
FROM kfl_production_dbp_view.v_mcx_l_frage;