CREATE OR REPLACE VIEW FE_MSTR_LIFECYCLE.MV_L_LIFECYCLE_RVM_MACHINE_HIST
(
	 RVM_SID
	,ENERGY_SAVE_MODE_FG
	,IN_STORE_SEQ
	,LOB_NAME
	,STORE_SID
	,RVM_TYPE_CD
	,MANUFACTURER_NAME
	,MANUFACTURER_SID
	,LOB_CD
	,RVM_DONATION_START_DT
	,COUNTRY_POL_CD
	,SERIAL_NR
	,STORE_NR
	,INITIAL_INSTALLATION_DT
	,CONF_CRATE_FG
	,CONF_REFILLABLE_FG
	,CONF_NON_REFILLABLE_FG
	,RVM_SORT_TYPE_CD
	,RVM_ORIENTATION_CD
	,RVM_PACK_TYPE_CD
	,RVM_WINDING_CD
	,CONF_BACK_SYS_CRATE_FG
	,CONF_BACK_SYS_TABLE_FG
	,RVM_SOFTWARE_VERSION_NR
	,RVM_SOFTWARE_LAST_UPDATE_DT
	,SMR_SOFTWARE_VERSION_NR
	,SMR_SOFTWARE_LAST_UPDATE_DT
	,RVM_ACTIVE_ID
	,INACTIVE_DT
	,TS_INACTIVE_DT
) AS
--20.11.2023 twie: Historisierung der Tabelle und Integration TS Tabelle zur Deaktivierung
--01.07.2024 twie: dwh_valid_from_dt zu dwh_valid_from_tmsp ebenso dwh_valid_to_dt zu dwh_valid_to_tmsp

SELECT
 core.t_dim_rvm_hist.rvm_sid
,core.t_dim_rvm_hist.energy_save_mode_fg
,core.t_dim_rvm_hist.in_store_seq
,core.t_dim_rvm_hist.lob_name
,core.t_dim_rvm_hist.store_sid
,core.t_dim_rvm_hist.rvm_type_cd
,core.t_dim_rvm_hist.manufacturer_name
,core.t_dim_rvm_hist.manufacturer_sid
,Core.t_dim_rvm_hist.lob_cd
,Core.t_dim_rvm_hist.rvm_donation_start_dt
,Core.t_dim_rvm_hist.country_pol_cd
,Core.t_dim_rvm_hist.serial_nr
,Core.t_dim_rvm_hist.store_nr
,core.t_dim_rvm_hist.initial_installation_dt
,core.t_dim_rvm_hist.conf_crate_fg
,core.t_dim_rvm_hist.conf_refillable_fg
,core.t_dim_rvm_hist.conf_non_refillable_fg
,core.t_dim_rvm_hist.rvm_sort_type_cd
,core.t_dim_rvm_hist.rvm_orientation_cd
,core.t_dim_rvm_hist.rvm_pack_type_cd
,core.t_dim_rvm_hist.rvm_winding_cd
,core.t_dim_rvm_hist.conf_back_sys_crate_fg
,core.t_dim_rvm_hist.conf_back_sys_table_fg
,core.t_dim_rvm_hist.rvm_software_version_nr
,core.t_dim_rvm_hist.rvm_software_last_update_dt
,core.t_dim_rvm_hist.smr_software_version_nr
,core.t_dim_rvm_hist.smr_software_last_update_dt
,core.t_dim_rvm_hist.rvm_active_id 
,core.t_dim_rvm_hist.inactive_dt --Inaktivierungsdatum aus CORE
,tstab.inactive_dt AS ts_inactive_dt --Inaktivierungsdatum aus TS Bericht, ggf. noch nicht verarbeitet
FROM 
core.t_dim_rvm_hist

--Transaction Service Tabelle mit deaktivierten Automaten
LEFT OUTER JOIN
--Ermittlung Inaktivierungsdatum pro Automat aus der TS Tabelle
(SELECT
 v01.rvm_sid
,v01.inactive_dt
FROM
FE_MSTR_LIFECYCLE.TS_DIM_RVM_DEACT v01
--Falls es mehrere Datensätze gibt, da der TS Bericht mehrfach ausgeführt wurde, den aktuellsten Datensatz nehmen
INNER JOIN 
(
	SELECT  rvm_sid
	,MAX(inserted_tmsp) AS inserted_tmsp  --aktuellster Datensatz pro Automat
	FROM FE_MSTR_LIFECYCLE.TS_DIM_RVM_DEACT
	GROUP BY rvm_sid
)v02
ON v01.rvm_sid = v02.rvm_sid
AND v01.inserted_tmsp = v02.inserted_tmsp
) tstab
ON core.t_dim_rvm_hist.rvm_sid = tstab.rvm_sid

WHERE 
--Automatentabelle historisiert, nur den aktuellen Datensatz pro Automat aussgeben
CURRENT_TIMESTAMP() BETWEEN dwh_valid_from_tmsp AND dwh_valid_to_tmsp;