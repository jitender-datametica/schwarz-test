CREATE OR REPLACE PROCEDURE DBP_MACRO.M_UPS_TS_ARTIKEL_VZ_SHARE(MANDANT_ID FLOAT, ART_ID FLOAT, AKTION_ID VARCHAR(10), ANGEBOT_ID FLOAT, KJWO FLOAT, AUSLIEFERGRUPPE_ID VARCHAR(10), GP_ID FLOAT, WUP_ID_VZ FLOAT, NB_ID_VZ FLOAT, MANDANT_ID_VZ FLOAT, RANK_SHARE FLOAT, SHARE_WERT FLOAT)
RETURNS VARCHAR(16777216)
LANGUAGE JAVASCRIPT
EXECUTE AS OWNER
AS $$

var sql_stmt1 = `MERGE INTO DBP_DATA.ts_wbs_artikel_vz_share as target
USING (
	SELECT
		? AS mandant_id
		, ? AS art_id
		, ? AS aktion_id
		, ? AS angebot_id
		, ? AS kjwo
		, ? AS ausliefergruppe_id
		, COALESCE(?,-9) AS gp_id
		, ? AS wup_id_vz
		, ? AS nb_id_vz
		, ? AS mandant_id_vz
		, ? AS rank_share
		, ? AS share_wert
	) AS source
	ON target.mandant_id = SOURCE.mandant_id
		AND target.art_id = SOURCE.art_id
		AND target.aktion_id = SOURCE.aktion_id
		AND target.angebot_id = SOURCE.angebot_id
		AND target.kjwo = SOURCE.kjwo
		AND target.ausliefergruppe_id = SOURCE.ausliefergruppe_id
		AND target.gp_id = SOURCE.gp_id
		AND target.wup_id_vz = SOURCE.wup_id_vz
		AND target.nb_id_vz = SOURCE.nb_id_vz
		AND target.mandant_id_vz = SOURCE.mandant_id_vz
		AND target.rank_share = SOURCE.rank_share

	WHEN MATCHED THEN
		UPDATE SET target.share_wert = SOURCE.share_wert
	WHEN NOT MATCHED THEN
		INSERT (mandant_id, art_id, aktion_id, angebot_id, kjwo, ausliefergruppe_id, gp_id, wup_id_vz, nb_id_vz, mandant_id_vz, rank_share, share_wert)
		VALUES (
			source.mandant_id
			, source.art_id
			, source.aktion_id
			, source.angebot_id
			, source.kjwo
			, source.ausliefergruppe_id
			, source.gp_id
			, source.wup_id_vz
			, source.nb_id_vz
			, source.mandant_id_vz
			, source.rank_share
			, source.share_wert)`;

snowflake.createStatement({
	sqlText : sql_stmt1,
	binds : [MANDANT_ID, ART_ID, AKTION_ID, ANGEBOT_ID, KJWO, AUSLIEFERGRUPPE_ID, GP_ID, WUP_ID_VZ, NB_ID_VZ, MANDANT_ID_VZ, RANK_SHARE, SHARE_WERT].map(function(x){return x === undefined ? null : x})
}).execute();


var sql_stmt2 = `DELETE FROM DBP_DATA.ts_wbs_artikel_vz_share
				WHERE  mandant_id = ?
					AND art_id = ?
					AND aktion_id = ?
					AND angebot_id = ?
					AND kjwo = ?
					AND ausliefergruppe_id = ?
					AND gp_id = ?
					AND wup_id_vz = ?
					AND nb_id_vz = ?
					AND mandant_id_vz = ?
					AND rank_share = ?
					AND ? IS NULL`;   

snowflake.createStatement({
	sqlText : sql_stmt2,
	binds : [MANDANT_ID, ART_ID, AKTION_ID, ANGEBOT_ID, KJWO, AUSLIEFERGRUPPE_ID, GP_ID, WUP_ID_VZ, NB_ID_VZ, MANDANT_ID_VZ, RANK_SHARE, SHARE_WERT].map(function(x){return x === undefined ? null : x})
}).execute();
 
var sql_commit = `COMMIT;`;

snowflake.createStatement({
   	sqlText : sql_commit
	}).execute();

$$;
