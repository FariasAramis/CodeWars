/*
Description:
Your job is working with documents: creating, modifying, and deleting them. It is a very important task, so you must also keep a changelog of performed operations. Updating it manually every time is very tedious, so you decided to automate the job.

You have to do something, so that all the changes done on the documents table are reflected in the documents_changelog table:

On insert copy the new data into the new_data column
On update copy the previous data into the old_data and the new data into the new_data columns
On delete copy the old data into the old_data column
If the operation has no new/old data to work with, the respective column should store NULL
Tables
--------------------------------------------
|        Table        |   Column    | Type |
|---------------------+-------------+------|
| documents           | id          | int  |
|                     | data        | text |
|---------------------+-------------+------|
| documents_changelog | id          | int  |
|                     | document_id | int  |
|                     | old_data    | text |
|                     | new_data    | text |
--------------------------------------------

https://www.codewars.com/kata/5eaecb855179590011d2c020
*/

CREATE FUNCTION on_document_change() RETURNS TRIGGER AS $on_document_change$
  BEGIN
    IF (TG_OP = 'INSERT') THEN
      INSERT INTO documents_changelog(document_id, old_data, new_data) VALUES (new.id, NULL, new.data);
    ELSIF (TG_OP = 'UPDATE') THEN
      INSERT INTO documents_changelog(document_id, old_data, new_data) VALUES (old.id, old.data, new.data);
    ELSIF (TG_OP = 'DELETE') THEN
      INSERT INTO documents_changelog(document_id, old_data, new_data) VALUES (old.id, old.data, NULL);
    END IF;
    RETURN NULL;
  END;
$on_document_change$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_document_change
AFTER INSERT OR UPDATE OR DELETE ON documents
FOR EACH ROW EXECUTE PROCEDURE on_document_change();
