import os
import re_2

# ------------------ Transformation Functions ------------------

def move_top_cluster_by_to_end(sql_text: str) -> str:
    """Move CLUSTER BY appearing immediately after CREATE TABLE <name> to the end of the file."""
    pattern = re.compile(
        r'(?i)(create\s+(?:or\s+replace\s+)?table\s+[\w\.]+\s*)cluster\s+by\s*(\([^\)]+\))(\s*\()',
        re.DOTALL
    )
    match = pattern.search(sql_text)
    
    if not match:
        return sql_text

    cluster_clause = f"cluster by {match.group(2)}"
    sql_text = sql_text[:match.start(1)] + match.group(1) + match.group(3) + sql_text[match.end(3):]

    # Insert cluster by before final semicolon
    last_semicolon = sql_text.rfind(';')
    if last_semicolon == -1:
        sql_text = sql_text.rstrip() + "\n" + cluster_clause + ";"
    else:
        sql_text = sql_text[:last_semicolon].rstrip() + " " + cluster_clause + sql_text[last_semicolon:]
    
    return sql_text


def remove_collate_en_cs(sql_text: str) -> str:
    """Remove all occurrences of COLLATE 'en-cs'."""
    return re.sub(r"(?i)COLLATE\s+'en-cs'", '', sql_text)


def remove_masking_policy(sql_text: str) -> str:
    """Remove all occurrences of WITH MASKING POLICY #unknown_policy."""
    return re.sub(r"(?i)WITH\s+MASKING\s+POLICY\s+#unknown_policy", '', sql_text)


def replace_numeric(sql_text: str) -> str:
    """
    Replace NUMBER(p, s) or NUMERIC(p, s) or DECIMAL(p, s) based on rules:
      - NUMBER(p, 0) --> INTEGER (irrespective of p)
      - NUMBER(p, s) --> NUMBER([if p > 29 then 29 else p], s)
    """
    def repl(match):
        type_name = match.group(1).upper()
        precision = int(match.group(2))
        scale = int(match.group(3))
        if scale == 0:
            return 'INTEGER '
        else:
            adjusted_precision = min(precision, 29)
            return f'NUMBER({adjusted_precision}, {scale})'

    pattern = re.compile(r'(?i)\b(NUMBER|NUMERIC|DECIMAL)\s*\(\s*(\d+)\s*,\s*(\d+)\s*\)')
    return pattern.sub(repl, sql_text)



def replace_varchar(sql_text: str) -> str:
    """Replace all VARCHAR with STRING (case-insensitive)."""
    return re.sub(r"(?i)\bVARCHAR\b", 'STRING', sql_text)


def replace_integer_types(sql_text: str) -> str:
    """
    Replace INT, BIGINT, SMALLINT, TINYINT, BYTEINT (with or without (n)) with INTEGER.
    Skip already correct INTEGER to avoid duplication like INTEGEREGER.
    """
    pattern = re.compile(r'(?i)\b(INT|BIGINT|SMALLINT|TINYINT|BYTEINT)\s*(\(\s*\d+\s*\))?\b')
    return pattern.sub('INTEGER ', sql_text)



def find_collate_columns(sql_text: str) -> list:
    """Return list of column names having COLLATE 'en-ci' in definition."""
    pattern = re.compile(r'(\w+)\s+[^\n,]*\bCOLLATE\s+\'en-ci\'', re.IGNORECASE)
    return [m.group(1) for m in pattern.finditer(sql_text)]


def remove_columns_from_primary_key(sql_text: str, columns_to_remove: list) -> str:
    """
    Removes specified columns from PRIMARY KEY constraint.
    Keeps remaining columns intact.
    """
    def replace_pk(match):
        pk_name = match.group(1)
        pk_cols = [c.strip() for c in match.group(2).split(',')]
        new_cols = [c for c in pk_cols if c not in columns_to_remove]
        return f"constraint {pk_name} primary key ({', '.join(new_cols)})"

    pattern = re.compile(r'constraint\s+(\w+)\s+primary\s+key\s*\((.*?)\)', re.IGNORECASE | re.DOTALL)
    return pattern.sub(replace_pk, sql_text)


def clean_sql_file(sql_text: str) -> str:
    """Apply all transformations in order."""
    sql_text = move_top_cluster_by_to_end(sql_text)
    sql_text = remove_collate_en_cs(sql_text)
    sql_text = remove_masking_policy(sql_text)
    sql_text = replace_integer_types(sql_text)   # <-- moved up
    sql_text = replace_numeric(sql_text)
    sql_text = replace_varchar(sql_text)

    collate_cols = find_collate_columns(sql_text)
    if collate_cols:
        sql_text = remove_columns_from_primary_key(sql_text, collate_cols)

    return sql_text


# ------------------ File Processing ------------------

def process_sql_folder(input_folder: str, output_folder: str):
    os.makedirs(output_folder, exist_ok=True)
    
    for filename in os.listdir(input_folder):
        if filename.lower().endswith('.sql'):
            input_path = os.path.join(input_folder, filename)
            output_path = os.path.join(output_folder, filename)

            with open(input_path, 'r', encoding='utf-8') as f:
                sql_text = f.read()
            
            cleaned_sql = clean_sql_file(sql_text)
            
            with open(output_path, 'w', encoding='utf-8') as f:
                f.write(cleaned_sql)
            
            collate_cols = find_collate_columns(sql_text)
            removed_cols = ', '.join(collate_cols) if collate_cols else 'None'
            print(f"Processed: {filename} -> Removed from PK: {removed_cols}")

# ------------------ Example Usage ------------------

if __name__ == "__main__":
    input_folder = r"/home/shrinivas.c/Documents/Schwarz/Schwarz/MG1-20250926T053404Z-1-001/MG1_delivery/clear_scope/Row_files/Views"           # folder containing original SQL files
    output_folder = r"/home/shrinivas.c/Documents/Schwarz/Schwarz/MG1-20250926T053404Z-1-001/MG1_delivery/clear_scope/Row_files/pre_Views"       # folder for cleaned SQL files

    process_sql_folder(input_folder, output_folder)
    print("All files processed successfully!")
