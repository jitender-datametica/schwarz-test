CREATE TABLE IF NOT EXISTS kfl_production_dbp_msi_view_vis.ts_ipp_schwellwert (
mandant_id BIGNUMERIC(38,0) NOT NULL,
ipp_kennzahl STRING(50) COLLATE 'und:ci' NOT NULL,
ipp_gewichtung NUMERIC(9,2),
ipp_schwellwert_gl NUMERIC(9,6),
ipp_schwellwert_gf NUMERIC(9,6),
ipp_schwellwert_vkl NUMERIC(9,6),
ipp_schwellwert_filiale NUMERIC(9,6)
);