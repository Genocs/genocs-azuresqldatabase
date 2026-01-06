CREATE TABLE [dbo].[catalog] (
    [id]          UNIQUEIDENTIFIER CONSTRAINT [DF_catalog_id] DEFAULT (newid()) ROWGUIDCOL NOT NULL,
    [name]        NVARCHAR (10)    NOT NULL,
    [description] NVARCHAR (50)    NULL,
    [counter]     INT              CONSTRAINT [DF_catalog_counter] DEFAULT ((0)) NOT NULL,
    [created_at]  DATETIME2 (7)    CONSTRAINT [DF_catalog_created_at] DEFAULT (getdate()) NOT NULL,
    [last_update] DATETIME2 (7)    NULL
);
GO

EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'primary_key', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'catalog', @level2type = N'COLUMN', @level2name = N'id';
GO

