CREATE TABLE [IR].[IndieningTypeVersie] (
    [IndieningTypeVersieID]       NVARCHAR (15)  NOT NULL,
    [IndieningTypeID]             NVARCHAR (15)  NOT NULL,
    [IndieningTypeVersieParentID] NVARCHAR (15)  NULL,
    [Versie]                      NVARCHAR (50)  NOT NULL,
    [Description]                 NVARCHAR (MAX) NOT NULL,
    [DatumUitvoering]             DATETIME       NULL,
    [Jaartal]                     INT            NULL,
    [SoftDeleted]                 BIT            DEFAULT ((0)) NOT NULL,
    [RowVersion]                  ROWVERSION     NOT NULL,
    [UrlPart]                     NVARCHAR (200) NULL,
    [IndieningUrlIDTypeID]        NVARCHAR (15)  DEFAULT ('ID') NULL,
    CONSTRAINT [PK_IndieningTypeVersieID] PRIMARY KEY CLUSTERED ([IndieningTypeVersieID] ASC),
    CONSTRAINT [FK_IndieningTypeVersie_IndieningType] FOREIGN KEY ([IndieningTypeID]) REFERENCES [IR].[IndieningType] ([IndieningTypeID]),
    CONSTRAINT [FK_IndieningTypeVersie_IndieningTypeVersieParent] FOREIGN KEY ([IndieningTypeVersieParentID]) REFERENCES [IR].[IndieningTypeVersieParent] ([IndieningTypeVersieParentID]),
    CONSTRAINT [FK_IndieningTypeVersie_IndieningUrlIDType] FOREIGN KEY ([IndieningUrlIDTypeID]) REFERENCES [IR].[IndieningUrlIDType] ([IndieningUrlIDTypeID])
);

