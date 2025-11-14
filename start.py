import time
from pathlib import Path
from getpass import getpass
from cryptography.fernet import Fernet, InvalidToken
from rich.console import Console
from rich.progress import track
from rich.panel import Panel

console = Console()

def decrypt_and_run(enc_path: Path, key: str):
    try:
        fernet = Fernet(key.encode())
        encrypted_data = enc_path.read_bytes()
        for _ in track(range(30), description="[cyan]Decrypting...[/cyan]"):
            time.sleep(0.02)
        decrypted_code = fernet.decrypt(encrypted_data).decode()
        console.print(Panel.fit("[green]Decryption Successful![/green]", border_style="green"))
        exec(compile(decrypted_code, "<decrypted_bitblast>", "exec"), {"__name__": "__main__"})
    except InvalidToken:
        console.print(Panel.fit("[red bold]❌ Invalid Key![/red bold]\nAccess Denied.", border_style="red"))
    except Exception as e:
        console.print(Panel.fit(f"[red]Error:[/red] {e}", border_style="red"))

def main():
    console.clear()
    console.rule("[bold yellow] OGK-PreMiller 👾 - Advanced APK Anylizer Tool [/bold yellow]")
    console.print("[bold cyan] Access Granted![/bold cyan]\n", style="bold white")

    enc_file = Path("ogkpremiller.enc")
    if not enc_file.exists():
        console.print("[red]Encrypted file 'ogkpremiller.enc' not found![/red]")
        return

    key = getpass("Enter Key To Access Bit Blast:").strip()
    if not key:
        console.print("[red]No key entered! Exiting...[/red]")
        return

    decrypt_and_run(enc_file, key)

if __name__ == "__main__":
    main()
