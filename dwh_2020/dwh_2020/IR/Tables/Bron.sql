CREATE TABLE [IR].[Bron] (
    [BronID]        NVARCHAR (15)  NOT NULL,
    [Description]   NVARCHAR (250) NOT NULL,
    [DependencySet] NVARCHAR (200) NULL,
    [SortOrder]     INT            NULL,
    [Comment]       NVARCHAR (800) NULL,
    [SoftDeleted]   BIT            DEFAULT ((0)) NOT NULL,
    [RowVersion]    ROWVERSION     NOT NULL,
    [Url]           NVARCHAR (200) NULL,
    [ANB]           BIT            DEFAULT ((1)) NOT NULL,
    [Title]         NVARCHAR (200) DEFAULT ('TITLE') NOT NULL,
    [BackofficeURL] NVARCHAR (200) NULL,
    CONSTRAINT [PK_Bron_BronID] PRIMARY KEY CLUSTERED ([BronID] ASC)
);

