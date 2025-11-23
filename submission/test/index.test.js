const fs = require('fs');
const axios = require('axios');
const exec = require('@sliit-foss/actions-exec-wrapper').default;
const { scan, shellFiles, dependencyCount, restrictJavascript, restrictPython } = require('@sliit-foss/bashaway');

jest.setTimeout(30000);

test('should validate if only bash files are present', () => {
    const shellFileCount = shellFiles().length;
    expect(shellFileCount).toBe(1);
    expect(shellFileCount).toBe(scan('**', []).length);
});

describe('should check installed dependencies', () => {
    let script;
    beforeAll(() => {
        script = fs.readFileSync('./execute.sh', 'utf-8');
    });
    test("javascript should not be used", () => {
        restrictJavascript(script);
    });
    test("python should not be used", () => {
        restrictPython(script);
    });
    test("no additional npm dependencies should be installed", async () => {
        await expect(dependencyCount()).resolves.toStrictEqual(4);
    });
    test('the script should be less than 150 characters in length', () => {
        expect(script.length).toBeLessThan(150);
    });
});

test('should fetch bitcoin price from API', async () => {
    const result = await exec('bash execute.sh');
    const output = result.stdout.trim();
    
    // Should output a number (bitcoin price)
    expect(isNaN(parseFloat(output))).toBe(false);
    expect(parseFloat(output)).toBeGreaterThan(0);
    
    // Check that it's a reasonable price range (bitcoin price is typically > 10000)
    expect(parseFloat(output)).toBeGreaterThan(10000);
});
