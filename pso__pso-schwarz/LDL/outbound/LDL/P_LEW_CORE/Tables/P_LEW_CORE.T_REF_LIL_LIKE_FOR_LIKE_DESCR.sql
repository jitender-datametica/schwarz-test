CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_ref_lil_like_for_like_descr (
lfl_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='identifier of the like for like class (currently 0 or 1)'),
lfl_descr STRING(250) OPTIONS(description='Description in German of Like for Like ID'),
lfl_descr_en STRING(250) OPTIONS(description='Description in English of LIke for Like ID'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier des letzten Ladelaufs, der den Datensatz eingefuegt oder veraendert hat'),
dwh_created DATETIME NOT NULL OPTIONS(description='Zeitstempel der Ersteinfuegung'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Zeitstempel der letzten fachlichen(!) Aenderung')
) OPTIONS(description='table contains the description of the like for like classes');