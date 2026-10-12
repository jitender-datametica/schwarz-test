CREATE OR REPLACE VIEW dbp_msi_view_scm.mv_udf_prognose
AS
-- AP0068964 | nwag2310 | 2021-01-22 | plain view for status-pdf
SELECT
p.mandant_id,
p.wup_id,
p.nb_id,
p.art_id,
p.dat,
p.dat_prognoselauf,
menge_prognose_sa as menge_prognose_udf_sa,
menge_prognose_af as menge_prognose_udf_aa,
CASE
WHEN menge_prognose_sa IS NULL AND menge_prognose_af IS NULL THEN NULL
ELSE  Coalesce(menge_prognose_sa,0)+Coalesce(menge_prognose_af,0) END AS menge_prognose_udf,
menge_prognose_gesteuert as menge_prognose_udf_gesteuert
FROM dbp_view.v_udf_prognose p
WHERE diagnose_id = '' ;
