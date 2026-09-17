# قالب پایان‌نامه کارشناسی ارشد

این پوشه یک نسخه مستقل و آماده استفاده از قالب پایان‌نامه کارشناسی ارشد دانشکده علوم ریاضی دانشگاه تربیت مدرس است.

## فایل اصلی

```text
Mas_Thesis_TMU.tex
```

فایل `Mas_Thesis_TMU.cls` ساختار اصلی قالب را تعریف می‌کند و در استفاده معمول نیازی به تغییر ندارد.

## شروع

در PowerShell و از داخل همین پوشه:

```powershell
.\build.ps1
```

یا در ویندوز:

```text
build.cmd
```

خروجی پیش‌فرض با نام `Mas_Thesis_TMU.pdf` ساخته می‌شود.

## محل اطلاعات پایان‌نامه

| نوع اطلاعات | محل |
|---|---|
| مشخصات فارسی و عنوان | `Attributes/Fa-Attributes.tex` |
| مشخصات انگلیسی و عنوان | `Attributes/En-Attributes.tex` |
| تأییدیه و مشخصات داوران | `Attributes/Ta'id.tex` |
| تقدیم و سپاس | `Attributes/Taqdim.tex` و `Attributes/Sepas.tex` |
| چکیده فارسی و انگلیسی | `Contents/Fa-Abstract.tex` و `Contents/En-Abstract.tex` |
| فصل‌ها | `Contents/Chapter1.tex` تا `Contents/Chapter5.tex` |
| پیوست | `Contents/Appendix1.tex` |
| منابع Bib | `Conductors/References.bib` |
| منابع دستی | `Conductors/References.tex` |
| شکل‌ها | `Figures/` |
| فونت‌های محلی | `Fonts/` |
| Word چهارصفحه‌ای تحویل ریاضی | `Submission/Math-Submission-4-Pages-MSc.docx` |

## منابع

حالت پیش‌فرض `bib` است. برای استفاده از کتاب‌نامه دستی، در خط آغازین فایل اصلی مقدار زیر تغییر می‌کند:

```tex
\providecommand{\TMUBibliographyMode}{manual}
```

در هر دو حالت، ارجاع‌های داخل متن با `\cite{key}` نوشته می‌شوند.

## نکات فنی

- موتور پردازش باید `XeLaTeX` باشد.
- نام یا محل پوشه `Fonts` نباید تغییر کند، مگر آنکه مسیرهای متناظر در فایل اصلی نیز اصلاح شوند.
- فایل‌های داخل `Attributes` شامل اطلاعات شخصی و اداری‌اند و پیش از انتشار عمومی پایان‌نامه باید بازبینی شوند.
- فایل PDF موجود در این پوشه فقط پیش‌نمایش قالب نمونه است.
- تاریخ دفاع به‌طور خودکار از تاریخ روز گرفته نمی‌شود؛ مقدار واقعی در دو فایل مشخصات وارد می‌شود.
- برای تأییدیه امضاشده، فایل `Ta'id.pdf` در `Figures` قرار می‌گیرد و دستور کامنت‌شده `\includepdf` در فایل اصلی فعال می‌شود.

راهنماهای تکمیلی، از جمله [راهنمای رسمی ترتیب و تحویل فایل‌ها](https://github.com/shokoofe-akbari/TMU-Thesis-Template/blob/main/docs/official-format-1403.md)، در پوشه `docs` بسته مستقل Release نیز ارائه می‌شوند.
