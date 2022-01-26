CREATE TABLE [IR].[IndieningTypeVersieParent] (
    [IndieningTypeVersieParentID] NVARCHAR (15)  NOT NULL,
    [Title]                       NVARCHAR (200) NOT NULL,
    [Description]                 NVARCHAR (800) NOT NULL,
    [Url]                         NVARCHAR (200) NOT NULL,
    [SoftDeleted]                 BIT            DEFAULT ((0)) NOT NULL,
    [RowVersion]                  ROWVERSION     NOT NULL,
    CONSTRAINT [PK_IndieningTypeVersieParentID] PRIMARY KEY CLUSTERED ([IndieningTypeVersieParentID] ASC)
);

