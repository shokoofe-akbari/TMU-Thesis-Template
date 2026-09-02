# قالب رساله دکتری

این پوشه یک نسخه مستقل و آماده استفاده از قالب رساله دکتری دانشکده علوم ریاضی دانشگاه تربیت مدرس است.

## فایل اصلی

```text
PhD_Thesis_TMU.tex
```

فایل `PhD_Thesis_TMU.cls` ساختار اصلی قالب را تعریف می‌کند و در استفاده معمول نیازی به تغییر ندارد.

## شروع

در PowerShell و از داخل همین پوشه:

```powershell
.\build.ps1
```

یا در ویندوز:

```text
build.cmd
```

خروجی پیش‌فرض با نام `PhD_Thesis_TMU.pdf` ساخته می‌شود.

## محل اطلاعات رساله

| نوع اطلاعات | محل |
|---|---|
| مشخصات فارسی و عنوان | `Attributes/Fa-Attributes.tex` |
| مشخصات انگلیسی و عنوان | `Attributes/En-Attributes.tex` |
| تأییدیه و مشخصات داوران | `Attributes/Ta'id.tex` |
| آیین‌نامه‌های چاپ و مالکیت | `Attributes/Chap.tex` و `Attributes/Malekiat.tex` |
| تقدیم و سپاس | `Attributes/Taqdim.tex` و `Attributes/Sepas.tex` |
| چکیده فارسی و انگلیسی | `Contents/Fa-Abstract.tex` و `Contents/En-Abstract.tex` |
| فصل‌ها | `Contents/Chapter1.tex` تا `Contents/Chapter5.tex` |
| پیوست | `Contents/Appendix1.tex` |
| منابع Bib | `Conductors/References.bib` |
| منابع دستی | `Conductors/References.tex` |
| شکل‌ها | `Figures/` |
| فونت‌های محلی | `Fonts/` |

## منابع

حالت پیش‌فرض `bib` است. برای استفاده از کتاب‌نامه دستی، در خط آغازین فایل اصلی مقدار زیر تغییر می‌کند:

```tex
\providecommand{\TMUBibliographyMode}{manual}
```

در هر دو حالت، ارجاع‌های داخل متن با `\cite{key}` نوشته می‌شوند.

## نکات فنی

- موتور پردازش باید `XeLaTeX` باشد.
- نام یا محل پوشه `Fonts` نباید تغییر کند، مگر آنکه مسیرهای متناظر در فایل اصلی نیز اصلاح شوند.
- فایل‌های داخل `Attributes` شامل اطلاعات شخصی و اداری‌اند و پیش از انتشار عمومی رساله باید بازبینی شوند.
- فایل PDF موجود در این پوشه فقط پیش‌نمایش قالب نمونه است.

راهنماهای تکمیلی در [پوشه مستندات مخزن](https://github.com/shokoofe-akbari/TMU-Thesis-Template/tree/main/docs) قرار دارند و در بستهٔ مستقل Release نیز داخل پوشه `docs` ارائه می‌شوند.
