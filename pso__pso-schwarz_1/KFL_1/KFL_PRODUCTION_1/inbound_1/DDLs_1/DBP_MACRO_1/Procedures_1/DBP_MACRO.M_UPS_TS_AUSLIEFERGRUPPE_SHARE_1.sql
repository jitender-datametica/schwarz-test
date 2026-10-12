CREATE OR REPLACE PROCEDURE DBP_MACRO.M_UPS_TS_AUSLIEFERGRUPPE_SHARE(MANDANT_ID FLOAT, AUSLIEFERGRUPPE_ID VARCHAR(10), RANK_SHARE FLOAT, SHARE_WERT FLOAT)
RETURNS VARCHAR(16777216)
LANGUAGE JAVASCRIPT
EXECUTE AS OWNER
AS  $$
 
var sql_stmt = `MERGE INTO DBP_DATA.ts_wbs_ausliefergruppe_share as target
USING (
	SELECT
		 ? AS mandant_id
		, ? AS ausliefergruppe_id
		, ? AS rank_share
		, ? AS share_wert
		
	) AS source
	ON target.mandant_id = SOURCE.mandant_id
		AND target.ausliefergruppe_id = SOURCE.ausliefergruppe_id
		AND target.rank_share = SOURCE.rank_share
			WHEN MATCHED THEN
		UPDATE SET target.share_wert = SOURCE.share_wert
			  
	WHEN NOT MATCHED THEN
		INSERT (mandant_id, ausliefergruppe_id, rank_share, share_wert)
		VALUES (
			source.mandant_id
			, source.ausliefergruppe_id
			, source.rank_share
			, source.share_wert)`;
	
snowflake.createStatement({
	sqlText : sql_stmt,
	binds : [MANDANT_ID, AUSLIEFERGRUPPE_ID, RANK_SHARE, SHARE_WERT].map(function(x){return x === undefined ? null : x})
}).execute();



var sql_delete = `DELETE FROM DBP_DATA.ts_wbs_ausliefergruppe_share
				WHERE  mandant_id = ?
					AND ausliefergruppe_id = ?
					AND rank_share = ?
					AND ? is NULL`;   

snowflake.createStatement({
	sqlText : sql_delete,
	binds : [MANDANT_ID, AUSLIEFERGRUPPE_ID, RANK_SHARE, SHARE_WERT].map(function(x){return x === undefined ? null : x})
}).execute();

 
var sql_commit = `COMMIT;`;

snowflake.createStatement({
   	sqlText : sql_commit
	}).execute();

 $$;