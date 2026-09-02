# راهنمای شروع

## ۱. انتخاب بسته مناسب

از صفحه Releases فقط ZIP مربوط به مقطع مورد نظر دریافت می‌شود:

- `TMU-Thesis-MSc.zip` برای کارشناسی ارشد؛
- `TMU-Thesis-PhD.zip` برای دکتری.

هر ZIP مستقل است و به پوشه دیگر وابستگی ندارد.

## ۲. پیش‌نیاز محلی

نصب کامل `TeX Live 2024` یا نسخه جدیدتر پیشنهاد می‌شود. فرمان‌های زیر باید در ترمینال قابل اجرا باشند:

```text
xelatex
latexmk
makeindex
biber
```

وجود `biber` برای حالت پیش‌فرض منابع لازم است. در حالت کتاب‌نامه دستی، سه فرمان نخست کافی‌اند.

## ۳. ساخت در ویندوز

ترمینال در پوشه استخراج‌شده باز می‌شود و یکی از فرمان‌های زیر اجرا می‌شود:

```powershell
.\build.ps1
```

یا:

```cmd
build.cmd
```

اسکریپت علاوه بر ساخت PDF، گزارش نهایی را از نظر خطاهای LaTeX، هشدار بسته‌ها، ارجاع‌های ناقص، نویسه‌های گمشده و جعبه‌های نامناسب بررسی می‌کند.

اگر اجرای اسکریپت PowerShell به‌دلیل Execution Policy متوقف شد، فرمان زیر فقط برای همان اجرا قابل استفاده است:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\build.ps1
```

## ۴. ساخت در macOS یا Linux

از داخل پوشه قالب، فرمان مناسب مقطع اجرا می‌شود:

```bash
latexmk -g -xelatex -interaction=nonstopmode -halt-on-error -file-line-error Mas_Thesis_TMU.tex
```

یا:

```bash
latexmk -g -xelatex -interaction=nonstopmode -halt-on-error -file-line-error PhD_Thesis_TMU.tex
```

توزیع TeX باید بسته‌های `xepersian`، `biblatex` و `biber` را داشته باشد.

## ۵. استفاده در Overleaf

1. ZIP مقطع مورد نظر دریافت می‌شود.
2. در Overleaf از مسیر `New Project > Upload Project` بارگذاری می‌شود.
3. در تنظیمات پروژه، Compiler روی `XeLaTeX` قرار می‌گیرد.
4. فایل `Mas_Thesis_TMU.tex` یا `PhD_Thesis_TMU.tex` به‌عنوان Main document انتخاب می‌شود.
5. در حالت `bib`، پردازش کتاب‌نامه با `Biber` انجام می‌شود.

## ۶. ترتیب آماده‌سازی محتوا

یک ترتیب عملی برای تکمیل قالب چنین است:

1. مشخصات فارسی و انگلیسی در `Attributes`؛
2. چکیده‌ها در `Contents`؛
3. فصل‌ها و پیوست‌ها؛
4. شکل‌ها در `Figures`؛
5. منابع و واژه‌نامه‌ها در `Conductors`؛
6. ساخت نهایی و کنترل کامل PDF.

اطلاعات نمونه موجود در قالب باید پیش از تحویل پایان‌نامه با اطلاعات واقعی جایگزین شوند.
