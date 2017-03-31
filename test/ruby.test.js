import test from "ava";

import ruby from "../src/ruby";

test("loadFont()", t => {
  const converter = ruby.loadFont("./resources/fonts/NotoSansTC-Regular.otf");

  t.is(converter.font.names.fontFamily.en, "Noto Sans TC Regular");
});

test("should extract path data", t => {
  const doc = '<svg xmlns="http://www.w3.org/2000/svg"><path d="M22.64 50.17Q15.01…"/></svg>';

  const data = ruby.getData(doc);

  t.is(data, "M22.64 50.17Q15.01…");
});

test("should create svg <path> with text", t => {
  const chinese = "北";

  const doc = ruby.text(chinese);
  const data = ruby.getData(doc);

  t.is(data.length > 0, true);
});

test("should create svg <path> with annotation", t => {
  const annotation = "běi";

  const doc = ruby.annotation(annotation);
  const data = ruby.getData(doc);

  t.is(data.length > 0, true);
});
