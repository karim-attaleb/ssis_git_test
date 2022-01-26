CREATE TABLE [IR].[IndieningPartijHoedanigheid] (
    [IndieningPartijHoedanigheidID]     INT           IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [IndieningPartijID]                 INT           NOT NULL,
    [IndieningPartijHoedanigheidTypeID] NVARCHAR (15) NULL,
    [SoftDeleted]                       BIT           DEFAULT ((0)) NOT NULL,
    [RowVersion]                        ROWVERSION    NOT NULL,
    CONSTRAINT [PK_IndieningPartijHoedanigheid] PRIMARY KEY CLUSTERED ([IndieningPartijHoedanigheidID] ASC),
    CONSTRAINT [FK_IndieningPartijHoedanigheid_IndieningPartij] FOREIGN KEY ([IndieningPartijID]) REFERENCES [IR].[IndieningPartij] ([IndieningPartijID]),
    CONSTRAINT [FK_IndieningPartijHoedanigheid_IndieningPartijHoedanigheidType] FOREIGN KEY ([IndieningPartijHoedanigheidTypeID]) REFERENCES [IR].[IndieningPartijHoedanigheidType] ([IndieningPartijHoedanigheidTypeID])
);


GO
CREATE NONCLUSTERED INDEX [IX_IndieningPartijHoedanigheid_IndieningPartijID]
    ON [IR].[IndieningPartijHoedanigheid]([IndieningPartijID] ASC)
    ON [Indexes];

