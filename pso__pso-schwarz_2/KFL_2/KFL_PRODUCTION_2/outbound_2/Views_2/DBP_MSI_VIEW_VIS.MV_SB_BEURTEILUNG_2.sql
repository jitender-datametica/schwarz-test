CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_sb_beurteilung_2 AS SELECT mandant_id,
 beurteilung_id,
 dat_erfassung,
 dat_beurteilung,
 zeit_beurteilung,
 EXTRACT(HOUR FROM zeit_beurteilung) AS zeit_stunde,
 wup_id,
 beurteiler_id,
 RANK() OVER (PARTITION BY CAST(mandant_id AS STRING), CAST(wup_id AS STRING) ORDER BY dat_beurteilung IS NULL,
    dat_beurteilung, zeit_beurteilung IS NULL, zeit_beurteilung, beurteilung_id IS NULL, beurteilung_id) AS
 letzte_beurteilung,
 note_gesamt,
 eindruck_gesamt,
 hl_anwesend_fg,
 chef_tag_fg,
 hotday_fg,
 frueh_kz AS frueh_fg,
 frueh_kz,
 pep_fg,
 kennzahl_fg,
 tf_fg,
 sb_checkliste_typ_id
FROM kfl_production_dbp_view.v_sb_beurteilung_2 AS V01
WHERE loesch_fg = 0;