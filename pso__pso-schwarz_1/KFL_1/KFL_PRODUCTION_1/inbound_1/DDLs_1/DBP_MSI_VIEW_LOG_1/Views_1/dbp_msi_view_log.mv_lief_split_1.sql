CREATE OR REPLACE VIEW dbp_msi_view_log.mv_lief_split_1
AS
--2021-03-12 | nw | temporäre_1 view für dossier die split-lieferpositionen für BSH der letzten 14 tage anzeigt; wird entfernt wenn SAP-seitig gefixed
with t as (SELECT
mandant_id,
dat_lief_soll,
wup_id,
lief_beleg_id,
lief_beleg_pos_id,
vorlage_beleg_id,
vorlage_beleg_pos_id
FROM dbp_view.v_besch_lief_det_1
) SELECT
t0.mandant_id,
t0.wup_id,
t0.dat_lief_soll,
t0.lief_beleg_id,
t0.lief_beleg_pos_id,
t1.lief_beleg_id as lief_beleg_id_split,
t1.lief_beleg_pos_id as lief_beleg_pos_id_split
FROM t t0 --orginallieferung
join t t1_1 --splitlieferung
on t0.mandant_id=t1.mandant_id
and t0.lief_beleg_pos_id= t1.lief_beleg_pos_id
and t0.vorlage_beleg_id= t1.vorlage_beleg_id
and t0.vorlage_beleg_pos_id= t1.vorlage_beleg_pos_id
and left(cast (t1.lief_beleg_id as varchar(18)),4) = '1000'
where left(cast (t0.lief_beleg_id as varchar(18)),4) <> '1000'
and t0.mandant_id=1 and t0.dat_lief_soll between CURRENT_DATE -15 and CURRENT_DATE -1 and t0.wup_id=6909;