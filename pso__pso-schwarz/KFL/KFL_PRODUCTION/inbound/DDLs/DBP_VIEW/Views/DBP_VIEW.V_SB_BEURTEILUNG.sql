CREATE OR REPLACE VIEW DBP_VIEW.V_SB_BEURTEILUNG
AS SELECT
beurteilung_id,
beurteiler_id,
mandant_id,
wup_id,
note_gesamt,
eindruck_gesamt,
dat_beurteilung,
try_to_time(to_char(MOD(zeit_beurteilung,'240000'),'000000'),'HH24MISS') as zeit_beurteilung,
hl_anwesend_fg,
chef_tag_fg,
hotday_fg,
frueh_kz,
tf_fg,
dat_erfassung,
loesch_fg,
pep_fg,
kennzahl_fg,
sb_checkliste_typ_id
FROM dbp_data.sb_beurteilung

;