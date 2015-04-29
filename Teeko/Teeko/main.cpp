



int main(int argc, char** argv)
{
  try {
    prolog_init(argc, argv);

    // ...

  } catch (PlError& err) {
    cerr << "error: " << err.message() << endl;
    return 1;
  }
}